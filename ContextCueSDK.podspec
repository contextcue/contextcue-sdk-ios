Pod::Spec.new do |s|
  s.name             = 'ContextCueSDK'
  s.module_name      = 'ContextCueSDK'
  s.version          = '1.0.3'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.homepage         = 'https://github.com/contextcue/contextcue-sdk-ios'
  s.authors          = { 'ContextCue' => 'support@contextcue.com' }
  s.summary          = 'The Official ContextCue SDK is the easiest way to _ethically_ monetize your iOS application through ads'
  s.description      = <<-DESC
ContextCue is a privacy-focused advertising network that allows advertisers \n
and publishers to grow their business without tracking, collecting, or storing \n
user data. Ethically earn revenue by easily integrating with ContextCue ads. \n\n
To learn more or sign up for an account, go to https://contextcue.com. \n
DESC

  s.social_media_url = 'http://twitter.com/contextcue'
  s.source           = { :git => 'https://github.com/contextcue/contextcue-sdk-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.frameworks       = [
    'Foundation',
    'UIKit'
  ]
  s.source_files = 'ContextCueSDK/**/*.{h,swift}'
  s.swift_version = '4.2'
end