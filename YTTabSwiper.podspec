#
# Be sure to run `pod lib lint YTTabSwiper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YTTabSwiper'
  s.version          = '0.1.0'
  s.summary          = 'A UITabBarController delegate that allows swipe gesture to switch between tabs.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A UITabBarController delegate that allows swipe gesture to switch between tabs. No need to subclass, no method swizzling, no changes to view hierarchy. If you use storyboard, you even don't need to write one line of code.
                       DESC

  s.homepage         = 'https://github.com/yeatse/YTTabSwiper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yang Chao' => 'iyeatse@gmail.com' }
  s.source           = { :git => 'https://github.com/yeatse/YTTabSwiper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'YTTabSwiper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YTTabSwiper' => ['YTTabSwiper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
