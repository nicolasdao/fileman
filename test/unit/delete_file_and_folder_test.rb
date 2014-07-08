require 'test_helper'

describe Fileman.remove do
	let(:folder_name) { "TestFolder" }

	before do
		FileUtils.mkdir folder_name
		FileUtils.mkdir "#{folder_name}/SubFolder_1"
		FileUtils.mkdir "#{folder_name}/SubFolder_2"
		FileUtils.mkdir "#{folder_name}/SubFolder_1/test_file.txt"
		FileUtils.mkdir "#{folder_name}/SubFolder_2/test_file.txt"
	end

	after do
		FileUtils.remove_dir 'TestFolder'
	end

	describe '#delete folder' do

		it 'delete the folder and all its content recursively' do
			File.directory?(folder_name).must_equal true
			Fileman.remove folder_name
			File.directory?(folder_name).must_equal false
		end
	end
end