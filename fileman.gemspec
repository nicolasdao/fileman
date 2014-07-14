# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
version = "0.1.%s" % ((Time.now.utc - Time.utc(2014, 7, 8))/60).round
version_file_path = File.join(lib, "fileman", "version.rb")
updated_content = nil

# update content
File.open(version_file_path, "rb") do |f|
content = f.read
updated_content = content.gsub(/(?<=").*?(?=")/, "%s" % version)
end

# overwrite version.rb with new content
File.open(version_file_path, "w") do |f|
f.write(updated_content)
end

Gem::Specification.new do |spec|
  spec.name          = "fileman"
  spec.version       = version
  spec.authors       = ["nicolasdao"]
  spec.email         = ["nicolas.dao@gmail.com"]
  spec.summary       = %q{Files and directories management in windows with super powers}
  spec.description   = %q{Enhance files and directories management in windows(e.g. deleting files and folders whose path is longer than 260 charatcers)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['fileman', 'fm']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "turn", "~> 0.9"
end
