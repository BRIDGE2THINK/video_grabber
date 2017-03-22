module VideoGrabber
  class Application

    def initialize(options)
      set_options(options)
    end

    def call
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
