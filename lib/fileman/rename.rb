require 'fileutils'

module Fileman
	module_function

	# Rename file or folder. If the item is a folder, subfolders and files can optionally
	# be recursively renamed to. 
	#
	# Arguments:
	# ----------
	# +item_path+			Item's path
	# +new_name+			New name that is used to rename the item. If the item is a folder,
	# 						subfolders and files can optionally be recursively renamed to. 
	# 						If there is multiple subfolders, then an incremetal number is appened
	# 						straight after the 'new_name'(e.g. if new_name is 'a', and there are
	#						2 subfolder 'subf_a' and 'subf_b', then the new names will respectively 
	# 						be 'a1' and 'a2')
	# +options+				Optional parameters defined as follow:
	# 	+:recursive+		Default is false. If true, and if the item is a folder, then all the
	# 						folder's content is also renamed
	# 	+:include_files+	Default is false. If true, all files will also be renamed. In that case
	# 						the 'recursive' option is implicitly set to true
	#   +:ignore_ext+		Default is false. If true, and if 'include_files' is also true, then 
	# 						file's extensions are removed. 
	# 
	# Returns the new name of the root folder
	def rename(item_path, new_name, options={})
		include_files = !options[:include_files].nil? && options[:include_files]
		recursive = include_files ? true : (!options[:recursive].nil? && options[:recursive])
		ignore_ext = !options[:ignore_ext].nil? && options[:ignore_ext]
		increment_name = lambda { |inc| inc == 0 ? new_name : "#{new_name}#{inc}" }

		try_rename_item = lambda { |counter, file, parent_folder, file_ext|
			final_name = nil
			begin
				while File.exists?(File.join(parent_folder, "#{increment_name.call(counter)}#{file_ext}")) do 
					counter+=1 
				end
				final_name = increment_name.call(counter)
				final_name = "#{final_name}#{file_ext}" unless ignore_ext
				FileUtils.mv file, File.join(parent_folder, final_name)
			rescue Errno::EACCES => eaccess # permission denied
				final_name = nil
			rescue Exception => e
				raise e
			end
			final_name
		}

		rename_item = lambda { |i|
			parent_folder = File.expand_path("../", i)
			file_ext = ignore_ext ? '' : File.extname(i)
			counter = 0
			final_name = nil
			while final_name == nil
				final_name = try_rename_item.call(counter, i, parent_folder, file_ext)
				counter += 1
			end
			File.join(parent_folder, final_name)
		}

		recursively_rename_item = lambda { |i|
			item_is_dir = File.directory? i
			new_item_path = rename_item.call(i) unless !item_is_dir && !include_files # rename current item

			if item_is_dir && recursive # if current is a folder, rename all its children
				all_folder_children = Dir.glob("#{new_item_path}/*", File::FNM_DOTMATCH) - ["#{new_item_path}/.", "#{new_item_path}/.."]
				all_folder_children.each { |c| recursively_rename_item.call(c) }
			end

			new_item_path
		}

		return recursively_rename_item.call(item_path)
	end
end