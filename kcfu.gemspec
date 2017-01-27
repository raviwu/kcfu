# coding: utf-8
require 'rake'

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kcfu/version'

Gem::Specification.new do |spec|
  spec.name          = "kcfu"
  spec.version       = Kcfu::VERSION
  spec.authors       = ["Ravi Wu"]
  spec.email         = ["raviwu@gmail.com"]

  spec.summary       = "KCFU (Kindle Clipping File Util) simply helps to parse the `My Clippings.txt` file into separated txt file with `Book Title 1.txt`, `Book Title 2.txt` based on the clippings's book title information."
  spec.description   = "KCFU (Kindle Clipping File Util) simply helps to parse the `My Clippings.txt` file into separated txt file with `Book Title 1.txt`, `Book Title 2.txt` based on the clippings's book title information."
  spec.homepage      = "https://github.com/raviwu/kcfu"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files        += FileList["lib/**/*.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "kindleclippings", "~> 1.4.0"
end
