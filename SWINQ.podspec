Pod::Spec.new do |s|

  s.name         = "SWINQ"
  s.version      = "0.0.3"
  s.summary      = "LINQ in Swift 2.0"
  s.description  = <<-DESC
                   Swift integrated queries on commonly used Swift data structures such as Arrays and Dictionaries.
				   DESC

  s.homepage     = "https://github.com/jlai403/SWINQ"
  s.license      = 'MIT'
  s.author             = { "Joey" => "joey@jlai.ca" }
  s.social_media_url   = "http://twitter.com/jlai_"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source       = { :git => "https://github.com/jlai403/SWINQ.git", :tag => "v0.0.3-alpha" }

  s.source_files  = "SWINQ/**/*.{swift}"
  #s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"

  s.framework  = "Foundation"
  # s.frameworks = "Foundation", "AnotherFramework"
end
