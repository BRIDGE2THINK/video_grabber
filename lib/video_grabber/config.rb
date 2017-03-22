module VideoGrabber

  # Access point for the gem configurations.
  #
  # @return [VideoGrabber::Configuration] a configuration instance.
  def self.config
    @config ||= Configuration.new
  end   

  # Configure hook used in the gem initializer. Convinient way to set all the
  # gem configurations.
  #
  # example:
  #   VideoGrabber.configure do |config|
  #     config.depth = 3
  #   end
  #
  # @return [void]
  def self.configure
    yield config if block_given?
  end

  class Configuration

    attr_accessor :url, :keep_browser_open, :timeout

    def initialize
      @keep_browser_open = false
      @timeout           = 60
    end
  end
end