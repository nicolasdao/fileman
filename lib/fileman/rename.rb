require 'fileutils'

module Fileman
	module_function

	# Rename folder and all its subfolders
	#
	# Arguments:
	# ----------
	# +folder_path+			Folder's path
	# +new_name+			New name that is used to rename the folder and all its subfolder.
	# 						If there is multiple subfolders, then a incremetal number is appened
	# 						straight after the 'new_name'(e.g. if new_name is 'a', and there are
	#						2 subfolder 'subf_a' and 'subf_b', then the new names will respectively 
	# 						be 'a1' and 'a2')
	# +options+				Optional parameters defined as follow:
	# 	+:include_files+	If true, all files will also be renamed. Extensions will be removed. 
	# 						Default is false 
	#   +:ignore_ext+		If true, and if 'include_files' is also true, then file's extensions
	# 						are ignored. Default is false
	# 
	# Returns the new name of the root folder
	def rename_r(folder_path, new_name, options={})
		include_files = !options[:include_files].nil? && options[:include_files]
		ignore_ext = !options[:ignore_ext].nil? && options[:ignore_ext]
		increment_name = lambda { |inc| inc == 0 ? new_name : "#{new_name}#{inc}" }

		rename_item = lambda { |f|
			parent_folder = File.expand_path("../", f)
			file_ext = ignore_ext ? '' : File.extname(f)
			counter = 0
			while File.exists?(File.join(parent_folder, "#{increment_name.call(counter)}#{file_ext}")) do 
				counter+=1 
			end
			final_name = increment_name.call(counter)
			final_name = "#{final_name}#{file_ext}" unless ignore_ext
			FileUtils.mv f, File.join(parent_folder, final_name)
			final_name
		}

		final_root_folder_new_name = new_name
		all_items = Dir.glob("#{folder_path}/**/*", File::FNM_DOTMATCH) - %w[. ..]
		items_per_folder = all_items.group_by { |x| File.expand_path('../',x)}
		
		sorted_items = items_per_folder.map { |k,v| v.sort_by{|y| y}.reverse }.flatten.reverse 
		(sorted_items << folder_path).each { |f|
			if File.directory?(f)
				final_root_folder_new_name = rename_item.call(f)
			elsif include_files && File.file?(f)
				rename_item.call(f)
			end
		}
		return final_root_folder_new_name
	end
end