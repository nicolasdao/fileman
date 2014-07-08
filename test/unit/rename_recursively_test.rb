require 'test_helper'

describe Fileman.rename_r do
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

	describe '#rename folder' do

		it 'rename the folder and all its subfolders recursively' do
			File.directory?(folder_name).must_equal true
			File.directory?("#{folder_name}/SubFolder_1").must_equal true
			File.directory?("#{folder_name}/SubFolder_2").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_2/test_file.txt").must_equal true

			Fileman.rename_r folder_name, 'a'

			File.directory?(folder_name).must_equal true
			File.directory?("a/a1").must_equal true
			File.directory?("a/a2").must_equal true
			File.file?("a/a1/test_file.txt").must_equal true
			File.file?("a/a2/test_file.txt").must_equal true
		end

		it 'rename the folder and all its subfolders recursively, including all files if option :include_file is true' do
			File.directory?(folder_name).must_equal true
			File.directory?("#{folder_name}/SubFolder_1").must_equal true
			File.directory?("#{folder_name}/SubFolder_2").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_2/test_file.txt").must_equal true

			Fileman.rename_r folder_name, 'a', {:include_file => true}

			File.directory?(folder_name).must_equal true
			File.directory?("a/a1").must_equal true
			File.directory?("a/a2").must_equal true
			File.file?("a/a1/a").must_equal true
			File.file?("a/a2/a").must_equal true
		end
	end
end