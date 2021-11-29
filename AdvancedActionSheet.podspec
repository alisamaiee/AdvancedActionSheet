Pod::Spec.new do |spec|

  spec.name         = "AdvancedActionSheet"
  spec.version      = "1.0.4"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library for iOS, offering you advanced alert action sheet.
                   DESC

  spec.homepage     = "https://github.com/alisamaiee/AdvancedActionSheet"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Ali Samaiee" => "alisamaiee@live.com" }

  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/alisamaiee/AdvancedActionSheet.git", :tag => "#{spec.version}" }
  spec.source_files  = "AdvancedActionSheet/**/*.{h,m,swift}"
  spec.resource_bundles = { "AdvancedActionSheet" => ["AdvancedActionSheet/**/*.{xcassets}"] }

end