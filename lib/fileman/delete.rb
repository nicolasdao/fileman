require 'fileutils'
require 'fileman/rename'

module Fileman
	module_function

	def remove(folder_path)
		new_path = Fileman.rename(folder_path, 'a', {:include_files => true, :ignore_ext => true, :recursive => true})
		FileUtils.rm_rf new_path
		FileUtils.remove_dir new_path
	end
end