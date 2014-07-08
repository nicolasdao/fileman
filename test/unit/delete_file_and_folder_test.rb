require 'test_helper'

describe "#Fileman.remove" do
	let(:folder_name) { "TestFolder" }
	let(:new_folder_name) { "a" }

	before do
		FileUtils.remove_dir(folder_name) if File.directory?(folder_name)
		FileUtils.mkdir folder_name
		FileUtils.mkdir "#{folder_name}/SubFolder_1"
		FileUtils.mkdir "#{folder_name}/SubFolder_2"
		FileUtils.touch "#{folder_name}/SubFolder_1/test_file.txt"
		FileUtils.touch "#{folder_name}/SubFolder_2/test_file.txt"
	end

	after do
		FileUtils.remove_dir(new_folder_name) if File.directory?(new_folder_name)
	end

	describe '#delete folder' do

		it 'delete the folder and all its content recursively' do
			File.directory?(folder_name).must_equal true
			Fileman.remove folder_name
			File.directory?(folder_name).must_equal false
		end
	end
end