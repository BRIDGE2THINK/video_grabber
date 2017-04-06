# Video Grabber

__Video Grabber__ is a simple tool to get video tags from a given URL. It includes advanced techniques to desobfuscate advertisements, run through embedded iframes, run javascript, and other frivolities that could usually and notably prevent one to fetch the wanted video.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'video_grabber'
```

And then execute:

```shell
$ bundle
```
Or install it yourself as:

```ruby
$ gem install video_grabber
```
And require it in your application:

```ruby
irb(main):001:0> require 'video_grabber'
=> true
```

## Requirements

If you plan to use Firefox as your browser, `video_grabber` will then rely on [Headless](https://github.com/leonid-shevtsov/headless) (unless you specifically disable it). To get Headless working you will need linux and `xvfb`.

Install `xvfb` on Debian:

```shell
sudo apt-get install xvfb
```

Headless is used to run Firefox inside a headless display (in background).


## Usage

Start the Scraper

```ruby
video_grabber = VideoGrabber.new(url: 'https://en.wikipedia.org/wiki/Big_Buck_Bunny').call
```
Fetch your links and shut down your scraper:

```ruby
video_grabber.fetch_videos
=> ["<video  id=\"mwe_player_1\" poster=\"//upload.wikimedia.org/wikipedia/com...
```

If you want to fetch a new time those data, you can manually restart the service using:

```ruby
video_grabber.start
```

Or you can directly pass the param `keep_browser_open` during initialization.

## Parameters

 - **url:** The url of the resource containing the video(s)
 -  **timeout:**  *(default: 60)* The timeout for the scraper. Will trigger a `VideoGrabber::Timeout` if the delay is met.
 - **keep_browser_open** *(default: false)* If activated, will keep the scraper's browser open as long as you do not stop it (using the `stop` public method.). 
 - **headless_enabled** *(default: true)* If disabled, will open your browser to crawl your links.
 - **browser** *(default: :firefox)* Set the browser which will be used to browse websites .
- **html_attributes** *(default: {controls: true})* This option enables you to pass html attributes that will be passed to your crawled links elements.
 - **firefox_extension_path** If passed, your Scraper instance will run using the given extension (`.xpi` file). Your browser has to be set at Firefox. Useful if you want to benefit from an Adblocker for instance

## Versioning

__Video Grabber__ follows [Semantic Versioning 2.0](http://semver.org/).

## Contributing

1. Fork it ( https://github.com/bridge2think/video_grabber/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contact

Any question ? Feel free to contact me at `ss(at)bridge2think.com` .
Any issue ? Open a [ticket](https://github.com/bridge2think/video_grabber/issues) !

## License

Copyright (c) 2017 Bridge2Think AG

Released under the MIT license. See [LICENSE.md](https://github.com/bridge2think/video_grabber/blob/master/LICENSE.md) for more details.
