#!/usr/bin/env ruby

require 'fileman'
require 'colorize'

def help
	text = "usage: fileman <command> [<args>]\n" +
	"\n" +
	"The fileman commands are:\n" +
	" rename, or rn\t Rename a folder as well as all its content with the same name\n" +
	" remove, or rm\t Delete a folder\n" +
	"\n" +
	"For more details about each command, use fileman <command> -h"
	puts text.colorize(:yellow)
end

def rename_help(rename_command)
	text = "usage: fileman #{rename_command} <path> <new-name> [<args>]\n" +
	"\n" +
	"Optional arguments are:\n" +
	" -i\t Include files so they are also renamed\n" +
	" -e\t Remove files extension. Only valid if -i option is also specified" 
	puts text.colorize(:yellow)
end

def remove_help(rename_command)
	text = "usage: fileman #{rename_command} <folder path>"
	puts text.colorize(:yellow)
end

def command_help(command)
	case command
	when "rename"
		rename_help("rename")
	when "rn"
		rename_help("rn")
	when "remove"
		remove_help("remove")
	when "rm"
		remove_help("rm")
	else
		puts "Command #{command} does not exist. Use 'fileman help' to find out about the usage".colorize(:red)
	end
end

def get_rename_options
	args = ARGV.clone
	args.shift(3) # ignore the first 2 arguments by removing them from the array
	options = {}
	if (args.size > 0)
		args.each { |x|
			x.gsub('-', '').split('').each { |y|
				case y
				when 'i'
					options[:include_files] = true
				when 'e'
					options[:ignore_ext] = true
				end
			}
		}
	end
	return options
end

def get_rename_arguments
	arguments = {}
	args = ARGV.clone
	args.shift(1) # ignore the first argument by removing them from the array
	arguments[:path] = args[0]
	arguments[:name] = args[1]
	options = get_rename_options
	arguments[:include_files] = options[:include_files]
	arguments[:ignore_ext] = options[:ignore_ext]
	
	return arguments
end

# Usage: fileman rn "your_folder_path" "new_name" -ie
def rename
	argsize = ARGV.size
	if argsize == 1
		puts "Missing argument(0 for 2..3). Use 'fileman help' to find out about the usage".colorize(:red)
	elsif argsize == 2
		puts "Missing argument(1 for 2..3). Use 'fileman help' to find out about the usage".colorize(:red)
	else
		args = get_rename_arguments
		options = {}
		options[:include_files] = true if args[:include_files]
		options[:ignore_ext] = true if args[:ignore_ext]
		Fileman.rename_r(args[:path], args[:name], options) unless args[:error]
	end
end

def remove
	argsize = ARGV.size
	if argsize == 1
		puts "Missing argument(0 for 1). Use 'fileman help' to find out about the usage".colorize(:red)
	else
		folder_path = ARGV[1].downcase
		Fileman.remove folder_path
	end
end

argsize = ARGV.size

if argsize > 0
	main_command = ARGV[0].downcase

	if argsize > 1 && ARGV[1] == "-h"
		command_help main_command
	else
		case main_command
		when "rn"
			rename
		when "rename"
			rename
		when "rm"
			remove
		when "remove"
			remove
		when "help"
			help
		when "h"
			help
		else
			help
		end
	end
else
	help
end