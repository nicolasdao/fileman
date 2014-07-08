require "yaml"
require "erb"
require "pathname"

fixture_root = Pathname("../../fixtures").expand_path(__FILE__)

Fixtures = Hash.new do |hash, f_name|
	filepath = fixture_root.join("#{f_name}.yml")
	file_contents = open(filepath).read
	YAML.load(ERB.new(file_contents).result).to_hash
	hash[f_name] = YAML.load(ERB.new(file_contents).result).to_hash
end