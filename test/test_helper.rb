require 'minitest/spec'
require 'minitest/autorun'
require 'fileman'
require 'toolbelt/fixture'
require 'pathname'
require 'fileutils'

# Attempt to load turn to show formatted test results
begin
	require "turn"
	Turn.config.format = :pretty
	Turn.config.natural = true
rescue LoadError
end