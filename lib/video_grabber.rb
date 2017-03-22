require 'video_grabber/application'
require 'video_grabber/config.rb'
require 'video_grabber/scraper.rb'
require 'video_grabber/exceptions.rb'
require 'selenium-webdriver'
require 'headless'
require 'nokogiri'
require 'watir'
require 'pry'

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
