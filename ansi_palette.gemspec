# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ansi_palette/version'

Gem::Specification.new do |spec|
  spec.name          = "ansi_palette"
  spec.version       = AnsiPalette::VERSION
  spec.authors       = ["David Begin"]
  spec.email         = ["davidmichaelbe@gmail.com"]

  spec.summary       = %q{A gem for helping you color strings with ANSI escape codes.}
  spec.description   = %q{A gem for helping you color strings with ANSI escape codes.}
  spec.homepage      = "https://github.com/presidentJFK/ansi_palette"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
end
