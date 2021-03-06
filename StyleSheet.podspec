Pod::Spec.new do |s|
  s.name = "StyleSheet"
  s.version = "3.1.0"
  s.authors = { "Raman Fedaseyeu" => "werediver@gmail.com" }
  s.license = "MIT"
  s.homepage = "https://github.com/werediver/StyleSheet"
  s.source = { :git => "https://github.com/werediver/StyleSheet.git", :tag => "v#{s.version}" }
  s.summary = "Composable UI styles"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.source_files = "Sources/*.swift"
end
