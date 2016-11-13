Pod::Spec.new do |s|
  s.name         = "BasicLibrary"
  s.version      = "0.0.1"
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.8'
  s.summary      = "BasicLibrary is frameworks for MCX Basic."
  s.homepage     = "https://github.com/Hepohob/BasicLibrary"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Aleksei Neronov" => "aleksei.neronov@yahoo.com" }
  s.source       = { :git => "https://github.com/Hepohob/BasicLibrary.git", :tag => s.version.to_s }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/*.h"
  s.exclude_files = "Classes/Exclude"
  s.framework  = "Foundation"
  s.requires_arc = true
end
