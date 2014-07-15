# Fileman

Fileman was originally designed to solve the Windows delete issue when a folder contains files whose path is greater than 260 characters. Over time, it got extended to support other features like renaming files inside folders following patterns.

## Installation

Add this line to your application's Gemfile:

    gem 'fileman'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fileman

## Usage
### Overview 
Once installed, fileman is immediately available in the terminal through the 'fileman' or 'fm' command. For more details, simply type:
```sh
fm
```
### Examples
#### Delete a folder
```sh
fm rm your_folder
```
#### Rename a folder as well as all its subfolders
```sh
fm rn "your_folder" "new_name"
```
#### Rename a folder as well as all its subfolder, including files
```sh
fm rn "your_folder" "new_name" -i
```
#### Rename a folder as well as all its subfolder, including files without the files extension
```sh
fm rn "your_folder" "new_name" -ie
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fileman/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
