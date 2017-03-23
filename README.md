# Video Grabber

__Video Grabber__ is a simple tool to get video tags from a given URL. It includes advanced techniques to desobfuscate advertisements, run through embedded iframes, run javascript, and other frivolities that could usually and notably prevent one to fetch the wanted video.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'video_grabber'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install video_grabber

And require it in your application:

    irb(main):001:0> require 'video_grabber'
    => true

## Requirements

`video_grabber` relies on Firefox and [Headless](https://github.com/leonid-shevtsov/headless) (unless you specifically disable it). To get Headless working you will need linux and `xvfb`.

Install `xvfb` on Debian:

    sudo apt-get install xvfb

Headless is used to run Firefox inside a headless display (in background).


## Usage

Start the Scraper

    video_grabber = VideoGrabber.new(url: 'https://en.wikipedia.org/wiki/Big_Buck_Bunny').call

Fetch your links and shut down your scraper:

    video_grabber.fetch_videos
    => ["<video  id=\"mwe_player_1\" poster=\"//upload.wikimedia.org/wikipedia/com...

If you keep to use the scraper current session, you can manually restart the service using:

    video_grabber.start

Or you can directly path the option param `keep_browser_open` during initialization.

## Parameters

 - **url:** The url of the resource containing the video(s)
 -  **timeout:**  *(default: 60)* The timeout for the scraper. Will trigger a `VideoGrabber::Timeout` if the delay is met.
 - **keep_browser_open** *(default: false)* If activated, will keep the scraper's browser open as long as you do not stop it (using the `stop` public method.). 
 - **headless_enabled** *(default: true)* If disabled, will open your Firefox browser to crawl your links.
 - **firefox_extension_path** If passed, your Scraper instance will run using the given extension (`.xpi` file). Useful if you want to benefit from an Adblocker for instance

## Versioning

__Video Grabber__ follows [Semantic Versioning 2.0](http://semver.org/).

## Contributing

1. Fork it ( https://github.com/bridge2think/video_grabber/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contact

Any question ? Feel free to contact me at `contact(at)sidney.email` .
Any issue ? Open a [ticket](https://github.com/shideneyu/video_grabber/issues) !

## License

Copyright (c) 2017 Bridge2Think AG

Released under the MIT license. See [LICENSE.md](https://github.com/shideneyu/video_grabber/blob/master/LICENSE.md) for more details.
