#
# Be sure to run `pod lib lint TransitionCoordinator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TransitionCoordinator'
  s.version          = '0.1.0'
  s.summary          = 'TransitionCoordinator can be used to easily customize transition animations when pushing or presenting a view controller.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'TransitionCoordinator handles the use of custom animations when either pushing a view controller onto a navigation stack or when modally presenting a view controller.'

  s.homepage         = 'https://github.com/SimonMcFarlane/TransitionCoordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Simon McFarlane' => 'simon@plusplus.ltd' }
  s.source           = { :git => 'https://github.com/SimonMcFarlane/TransitionCoordinator.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.1'

  s.source_files = 'TransitionCoordinator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TransitionCoordinator' => ['TransitionCoordinator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
