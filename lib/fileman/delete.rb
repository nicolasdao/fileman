require 'fileutils'
require 'fileman/rename'

module Fileman
	module_function

	def remove(folder_path)
		new_name = Fileman.rename_r(folder_path, 'a', {:include_files => true})
		FileUtils.remove_dir new_name, true
	end
end