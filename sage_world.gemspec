
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sage_world/version"

Gem::Specification.new do |spec|
  spec.name          = "sage_world"
  spec.version       = SageWorld::VERSION
  spec.authors       = ["Abhishek Kanojia"]
  spec.email         = ["abhishek.kanojia@vinsol.com"]

  spec.summary       = %q{Ruby Wrapper for SageWorld.}
  spec.description   = %q{Ruby Wrapper for SageWorld.}
  spec.homepage      = "https://github.com/abhikanojia/sageworld.git"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware', '~> 0.12.2'
end
