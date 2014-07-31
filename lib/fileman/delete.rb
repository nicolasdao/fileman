require 'fileutils'
require 'fileman/rename'

module Fileman
	module_function

	def remove(folder_path)
		new_path = Fileman.rename(folder_path, 'a', {:include_files => true, :ignore_ext => true, :recursive => true})
		FileUtils.rm_rf new_path
		# based on different environment, you may need to remove the folder a second time
		FileUtils.remove_dir new_path if File.exists? new_path
	end
end