#!/bin/env ruby

require 'rubygems'
require 'uri'

# read log file and write to dirs
def read_file_and_write_to_dirs(path, filename)

  # save dir names to dirs array
  dirs = []
  # read file and write to dirs
  File.open(filename, "r") do |file|
    file.each_line do |line|

      # URLEncode
      line = URI.escape(line)
      dirs << line

      dir = File.join(path, line)
    
      # make a dir by the line for the name
      Dir.mkdir(dir) if !File.exist?(dir)
    
      # write a file inside the dir
      f = File.new("#{dir}/#{Time.now.to_i}", "w+")
      f.puts("test")
      f.close

    end
  end

  # return dirs
  dirs
end

# Count files for each dir
def count_files_for_each_dir(path, dirs)
  dirs.each do |dir|
  
    num = 0
    # count flag

    Dir.entries(File.join(path, dir)).each do |file|
      num = (num + 1) if file.to_s!="." and file.to_s!=".." and file.to_s!=".DS_Store"
    end
  
    # print result
    puts "#{dir} : #{num}"
  end
end

# read filename from console parameters
filename = ARGV[0]

# create tmp dir
tmp_path = "./tmp"
Dir.mkdir(tmp_path) if !File.exist?(tmp_path)

# read and write dirs
dirs = []
dirs = read_file_and_write_to_dirs(tmp_path, filename)

# count files
count_files_for_each_dir(tmp_path, dirs)

puts "Total is : #{dirs.length}\n"
