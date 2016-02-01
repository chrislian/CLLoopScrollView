
Pod::Spec.new do |s|

  s.name         = "CLLoopScrollView"
  s.version      = "0.0.1"
  s.summary      = "UIScrollview 循环播放图片"
  s.description  = <<-DESC
                    无限滑动更新图片,定时自动跳转到下一页
                   DESC
  s.homepage     = "http://github.com/chrislian/CLLoopScrollView"
  # s.screenshots  = "https://github.com/chrislian/CLLoopScrollView/blob/master/clloopscrollview.gif"
  s.license      = "MIT"
  s.author       = { "chrislian" => "chris0592@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/chrislian/CLLoopScrollView.git", :tag => "0.0.1" }
  s.source_files  = "CLLoopScrollView/CLLoopView/*.swift"
  s.framework  = "UIKit"
  s.requires_arc = true

end
