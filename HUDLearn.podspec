#
# Be sure to run `pod lib lint HUDLearn.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HUDLearn'
  s.version          = '0.1.0'
  s.summary          = 'A short description of HUDLearn.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/silence-majority/HUDLearn'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'silence-majority' => '931968649@qq.com' }
  s.source           = { :git => 'https://github.com/silence-majority/HUDLearn.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HUDLearn/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HUDLearn' => ['HUDLearn/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'MBProgressHUD','~> 0.9.2'
    s.dependency 'YTKNetwork'
    s.dependency 'SVProgressHUD'
end
