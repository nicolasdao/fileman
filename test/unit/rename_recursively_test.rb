require 'test_helper'

describe "#Fileman.rename" do
	let(:folder_name) { "TestFolder" }
	let(:new_folder_name) { "a" }

	before do
		FileUtils.remove_dir(folder_name) if File.directory?(folder_name)
		FileUtils.mkdir folder_name
		FileUtils.mkdir "#{folder_name}/SubFolder_1"
		FileUtils.mkdir "#{folder_name}/SubFolder_2"
		FileUtils.touch "#{folder_name}/SubFolder_1/test_file.txt"
		FileUtils.touch "#{folder_name}/SubFolder_1/test_file_1.txt"
		FileUtils.touch "#{folder_name}/SubFolder_2/test_file.txt"
	end

	after do
		FileUtils.remove_dir(new_folder_name) if File.directory?(new_folder_name)
	end

	describe 'rename folder' do

		it 'rename the folder' do
			File.directory?(folder_name).must_equal true
			File.directory?("#{folder_name}/SubFolder_1").must_equal true
			File.directory?("#{folder_name}/SubFolder_2").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file_1.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_2/test_file.txt").must_equal true

			Fileman.rename folder_name, new_folder_name

			File.directory?("a").must_equal true
			File.directory?("a/SubFolder_1").must_equal true
			File.directory?("a/SubFolder_2").must_equal true
			File.file?("a/SubFolder_1/test_file.txt").must_equal true
			File.file?("a/SubFolder_1/test_file_1.txt").must_equal true
			File.file?("a/SubFolder_2/test_file.txt").must_equal true
		end

		it 'rename the folder and all its subfolders recursively if the :recursive option is true' do
			File.directory?(folder_name).must_equal true
			File.directory?("#{folder_name}/SubFolder_1").must_equal true
			File.directory?("#{folder_name}/SubFolder_2").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file_1.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_2/test_file.txt").must_equal true

			Fileman.rename folder_name, new_folder_name, {:recursive => true}

			File.directory?("a").must_equal true
			File.directory?("a/a").must_equal true
			File.directory?("a/a1").must_equal true
			File.file?("a/a/test_file.txt").must_equal true
			File.file?("a/a/test_file_1.txt").must_equal true
			File.file?("a/a1/test_file.txt").must_equal true
		end

		it 'rename the folder and all its subfolders recursively, including all files, if both the :include_files and :recursive options are true' +
		'if option :include_files is true' do
			File.directory?(folder_name).must_equal true
			File.directory?("#{folder_name}/SubFolder_1").must_equal true
			File.directory?("#{folder_name}/SubFolder_2").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file_1.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_2/test_file.txt").must_equal true

			Fileman.rename folder_name, new_folder_name, {:include_files => true, :recursive => true}

			File.directory?("a").must_equal true
			File.directory?("a/a").must_equal true
			File.directory?("a/a1").must_equal true
			File.file?("a/a/a.txt").must_equal true
			File.file?("a/a/a1.txt").must_equal true
			File.file?("a/a1/a.txt").must_equal true
		end

		it 'rename the folder and all its subfolders recursively, including all files ' +
		'WITHOUT their extensions if options :include_files, :ignore_ext, and :recursive are true' do
			File.directory?(folder_name).must_equal true
			File.directory?("#{folder_name}/SubFolder_1").must_equal true
			File.directory?("#{folder_name}/SubFolder_2").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_1/test_file_1.txt").must_equal true
			File.file?("#{folder_name}/SubFolder_2/test_file.txt").must_equal true

			Fileman.rename folder_name, new_folder_name, {:include_files => true, :ignore_ext => true, :recursive => true}

			File.directory?("a").must_equal true
			File.directory?("a/a").must_equal true
			File.directory?("a/a1").must_equal true
			File.file?("a/a/a").must_equal true
			File.file?("a/a/a1").must_equal true
			File.file?("a/a1/a").must_equal true
		end
	end
end