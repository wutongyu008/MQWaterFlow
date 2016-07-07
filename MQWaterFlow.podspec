

Pod::Spec.new do |s|

  s.name         = "MQWaterFlow"
  s.version      = "0.0.1"
  s.license      = "MIT"
  s.summary      = "封装的各种流式布局"
  s.homepage     = "https://github.com/wutongyu008/MQWaterFlow"
  s.author             = { "梧桐雨08" => "wutongyu_08@163.com" }
  s.source       = { :git => "https://github.com/wutongyu008/MQWaterFlow.git", :tag => "s.version.to_s" }
  s.requires_arc = true
  s.description  = <<-DESC
  Fast encryption string, the current support for MD5 (16, 32), Sha1, Base64
DESC
  s.source_files  = "MQWaterFlow", "MQWaterFlow/**/*.{h,m}"
  s.platform     = :ios, "7.0"
  s.framework  = 'Foundation', 'CoreGraphics', 'UIKit'
  s.dependency  "MJExtension", "3.0.9"  
  s.dependency  "SDWebImage", "3.7.4"
  s.dependency  "MJRefresh", "3.1.0"
end
