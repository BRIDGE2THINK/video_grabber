module VideoGrabber
  class Application

    def initialize(options)
      set_options(options)
    end

    def call
      scraper = Scraper.new(config).start
    end

    private

    def config
      @config ||= ::VideoGrabber.config.dup
    end

    def set_options(options)
      options.each { |k, v| config.send("#{k}=", v) }
    end
  end
end
