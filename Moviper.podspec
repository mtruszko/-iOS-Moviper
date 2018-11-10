Pod::Spec.new do |s|
  s.name         = "Moviper"
  s.version      = "0.0.3"
  s.summary      = "Base Moviper architecture in Swift"
  s.homepage     = "https://github.com/mtruszko/-iOS-Moviper"
  s.license      = "MIT"
  s.author       = { "Marek" => "marektruszko@gmail.com" }
  s.source       = { :git => "https://github.com/mtruszko/-iOS-Moviper.git", :tag => "#{s.version}" }
  s.source_files = "Moviper/**/*.{swift}"
  s.ios.deployment_target = '9.0'
  s.swift_version = "4.2"
  s.dependency 'RxSwift', '4.3.1'
end
