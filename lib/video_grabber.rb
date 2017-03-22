require 'video_grabber/application'
require 'video_grabber/config.rb'

module VideoGrabber

  class << self

    attr_reader :application

    def new(opts)
      @application = VideoGrabber::Application.new(opts)
    end

    def call
      application.call
    end
  end
end
