require 'fileutils'
require 'fileman/rename'

module Fileman
	module_function

	def remove(folder_path)
		new_path = Fileman.rename(folder_path, 'a', {:include_files => true, :ignore_ext => true, :recursive => true})
		FileUtils.remove_dir new_path, true
	end
end