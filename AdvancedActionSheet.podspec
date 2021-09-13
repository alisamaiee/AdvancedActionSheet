Pod::Spec.new do |spec|

  spec.name         = "AdvancedActionSheet"
  spec.version      = "1.0.0"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
                   DESC

  spec.homepage     = "https://github.com/alisamaiee/AdvancedActionSheet"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Ali Samaiee" => "alisamaiee@live.com" }

  spec.ios.deployment_target = "12.1"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/alisamaiee/AdvancedActionSheet.git", :tag => "#{spec.version}" }
  spec.source_files  = "SwiftyLib/**/*.{h,m,swift}"
  spec.resource_bundles = { "RiverFramework-iOS" => ["RiverFramework-iOS/chatsubmodule-ios/**/*.{xib,storyboard,xcassets,caf,wav,json,bundle}"] }

end