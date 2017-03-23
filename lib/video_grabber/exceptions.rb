module VideoGrabber
  class Exception < StandardError; end
  class BrowserIsClosed < Exception; end
  class ExtensionError < Exception; end
  class TimeOut < Exception; end
end
