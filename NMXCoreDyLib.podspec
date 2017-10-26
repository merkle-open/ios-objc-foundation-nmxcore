#
# Be sure to run `pod lib lint NMXCoreDylib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name              = "NMXCoreDylib"
  s.version           = "0.3.0"
  s.summary           = "Namics Core Library used for iOS in a Swift project. Shall take care of reusable code. "
  s.documentation_url = 'https://namics.github.io/ios-objc-foundation-nmxcore/'
  s.homepage          = "https://github.com/namics/ios-objc-foundation-nmxcore"
  s.authors           = { "Adriano Segalada" => "adriano.segalada@namics.com", "Tobias Baube" => "tobias.baube@namics.com" }
  s.source            = { :git => "https://github.com/namics/ios-objc-foundation-nmxcore.git", :tag => "v"+s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.platform              = :ios, '9.0'
  s.license               = { :type => 'MIT' }

  s.ios.vendored_frameworks = 'Development/NMXCore.framework'
  s.requires_arc		= true
end
