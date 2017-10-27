#
# Be sure to run `pod lib lint NMXCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name              = "NMXCore"
  s.version           = "0.3.1"
  s.summary           = "Namics Core Library used for iOS in Objective-C. Shall take care of reusable code. "
  s.documentation_url = 'https://namics.github.io/ios-objc-foundation-nmxcore/'
  s.homepage          = "https://github.com/namics/ios-objc-foundation-nmxcore"
  s.authors           = { "Adriano Segalada" => "adriano.segalada@namics.com", "Tobias Baube" => "tobias.baube@namics.com" }
  s.source            = { :git => "https://github.com/namics/ios-objc-foundation-nmxcore.git", :tag => "v"+s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.platform              = :ios, '9.0'
  s.license               = { :type => 'MIT' }

  s.source_files = 'Development/NMXCore/**/*.{h,m}'
  s.requires_arc		= true
end
