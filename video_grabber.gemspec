# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'video_grabber/version'

Gem::Specification.new do |spec|
  spec.name                  = 'video_grabber'
  spec.version               = VideoGrabber::VERSION
  spec.authors               = ['sidney']
  spec.email                 = ['ss@bridge2think.com']
  spec.summary               = 'VideoGrabber is a simple tool to get video tags from a given URL'
  spec.description           = 'VideoGrabber crawl headlessly websites to extract their videos'
  spec.homepage              = 'https://github.com/bridge2think/video_grabber'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 1.9.3'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['video_grabber']
  spec.require_paths = ['lib']

  spec.add_dependency 'selenium-webdriver', '~> 2.53.4'
  spec.add_dependency 'watir'
  spec.add_dependency 'headless'
  spec.add_dependency 'nokogiri'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
