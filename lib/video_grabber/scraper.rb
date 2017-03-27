module VideoGrabber
  class Scraper

    attr_reader :url, :browser, :timeout, :keep_browser_open, :headless_enabled,
                :firefox_extension_path, :profile, :attributes

    def initialize(config)
      @keep_browser_open      = config.keep_browser_open
      @url                    = config.url
      @timeout                = config.timeout
      @headless_enabled       = config.headless_enabled
      @firefox_extension_path = config.firefox_extension_path
      @attributes             = config.attributes
    end

    def start
      open_browser
      browser.goto(url) ; self
    rescue ::Net::ReadTimeout
      stop
      raise ::VideoGrabber::TimeOut
    end

    def stop
      browser.close
    end

    def fetch_videos
      links_list = []
      links_list += browser.videos.map(&:html)

      links_list += ::Nokogiri::HTML(browser.html).xpath('//iframe').map do |iframe_node|
        ::Nokogiri::HTML(::CGI.unescapeHTML(iframe_node.to_s)).xpath('.//video').map{ |element| element.to_s }
      end.flatten

      links_list += begin
        html = ::CGI.unescapeHTML(browser.html)
        html = html.split('<video').map{|e| '<video ' + e if e.match('</video>')}.compact
        html = html.map{|e| e.split('</video>')[0..-2].join('</video>') + '</video>' }
      end

      stop unless keep_browser_open

      links_list = links_list.map{|element| element.split.join(" ") }.reject(&:empty?).uniq

      add_attributes(links_list) || links_list
    rescue ::Watir::Exception::Error
      raise ::VideoGrabber::BrowserIsClosed, 'Please restart the scraper (scraper_instance.start), or keep the browser open'
    end

  private

    def open_browser
      start_headless

      @profile       = ::Selenium::WebDriver::Firefox::Profile.new ; load_extension
      client         = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = timeout
      @browser       = ::Watir::Browser.new(:firefox, profile: profile, http_client: client)
    end

    def start_headless
      return unless headless_enabled

      ::Headless.new.start
    end

    def load_extension
      return unless firefox_extension_path

      @profile.add_extension(firefox_extension_path)
    rescue Selenium::WebDriver::Error::WebDriverError => e
      raise ::VideoGrabber::ExtensionError, e
    end

    def add_attributes(list)
      return unless attributes

      list.map do |element|

        parsed_element = Nokogiri::XML(element)

        attributes.each do |key, value|
          parsed_element.xpath('//video').first.set_attribute(key, value)
        end

        parsed_element.xpath('//video').to_s
      end
    end
  end
end
