require 'fileutils'
require 'fileman/rename'

module Fileman
	module_function

	def remove(folder_path)
		new_name = Fileman.rename_r(folder_path, 'a', {:include_files => true})
		new_path = File.expand_path("../#{new_name}", folder_path)
		FileUtils.remove_dir new_path, true
	end
end