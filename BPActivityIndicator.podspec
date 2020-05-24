
Pod::Spec.new do |s|
  s.name             = 'BPActivityIndicator'
  s.version          = '0.1.0'
  s.summary          = 'A customizable activity indicator view written in Swift 5'

  s.description      = <<-DESC
'BPActivityIndicator is a light-weight replacement for UIActivityIndicatorView based on Core Animation and Core Graphics. I can added to your project both programmatically and via Interface Builder.'
                       DESC

  s.homepage         = 'https://github.com/bluepixeltech/BPActivityIndicator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pouya Khansaryan' => 'bluepixel.technologies@gmail.com' }
  s.source           = { :git => 'https://github.com/bluepixeltech/BPActivityIndicator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.instagram.com/pouya.ios.dev/'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "12.0"
  }
  s.source_files = 'Source/**/*.swift'
  
end
