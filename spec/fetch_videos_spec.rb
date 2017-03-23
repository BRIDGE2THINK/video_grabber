describe ::VideoGrabber do

  let (:absolute_path) { 'file://' + File.expand_path(File.dirname(File.dirname(__FILE__))) + '/fixtures/' }

  it 'fetches the links correctly' do
    video_graber = VideoGrabber.new(url: absolute_path + 'normal.html').call
    expect(video_graber.fetch_videos).to eq(["<video src=\"normal.mp4\"></video>"])
  end

  it 'fetches the links even inside an iframe' do
    video_graber = VideoGrabber.new(url: absolute_path + 'iframe_embedded_video.html').call
    expect(video_graber.fetch_videos).to eq(["<video src=\"iframe.mp4\"></video>"])
  end
end