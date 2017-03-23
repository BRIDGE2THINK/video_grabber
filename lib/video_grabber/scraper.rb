module VideoGrabber
  class Scraper

    attr_reader :url, :browser, :timeout, :keep_browser_open

    def initialize(url, timeout, keep_browser_open)
      @keep_browser_open = keep_browser_open
      @url               = url
      @timeout           = timeout
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

      stop unless keep_browser_open

      links_list.reject(&:empty?)
    rescue Watir::Exception::Error 
      raise ::VideoGrabber::BrowserIsClosed, 'Please restart the scraper (scraper_instance.start), or keep the browser open'
    end

  private

    def open_browser
      ::Headless.new.start
      profile = ::Selenium::WebDriver::Firefox::Profile.new
      profile.add_extension('vendor/adblockplusfirefox.xpi')
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout       = timeout
      @browser             = ::Watir::Browser.new(:firefox, profile: profile, http_client: client)
    end
  end
end
