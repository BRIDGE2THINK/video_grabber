module VideoGrabber
  class Scraper

    attr_reader :url, :browser, :timeout, :keep_browser_open, :headless_enabled

    def initialize(url, timeout, keep_browser_open, headless_enabled)
      @keep_browser_open = keep_browser_open
      @url               = url
      @timeout           = timeout
      @headless_enabled  = headless_enabled
    end

    def start
      open_browser
      browser.goto(url) ; self
    rescue ::Net::ReadTimeout
      raise ::VideoGrabber::TimeOut
    end

    def stop
      browser.close
    end

    def fetch_videos
      links_list = []
      links_list += browser.videos.map(&:html)
      links_list += ::Nokogiri::HTML(browser.html).xpath('//iframe').map do |iframe_node|
        ::Nokogiri::HTML(CGI.unescapeHTML(iframe_node.to_s)).xpath('.//video').map{ |element| element.to_s }
      end.flatten
      link_list += begin
        html = CGI.unescapeHTML(browser.html)
        html = html.split('<video').map{|e| '<video ' + e if e.match('</video>')}.compact
        html = html.map{|e| e.split('</video>')[0..-2].join('</video>') + '</video>' }
      end

      stop unless keep_browser_open

      links_list.reject(&:empty?).unique
    rescue Watir::Exception::Error 
      raise ::VideoGrabber::BrowserIsClosed, 'Please restart the scraper (scraper_instance.start), or keep the browser open'
    end

  private

    def open_browser
      start_headless
      profile = ::Selenium::WebDriver::Firefox::Profile.new
      profile.add_extension('vendor/adblockplusfirefox.xpi')
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout       = timeout
      @browser             = ::Watir::Browser.new(:firefox, profile: profile, http_client: client)
    end

    def start_headless
      return unless headless_enabled

      ::Headless.new.start
    end
  end
end
