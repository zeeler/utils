#!/bin/env ruby
require 'rubygems'

def generate_password (length)
  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
  password = ""
  1.upto(length) { |i| password << chars[rand(chars.size-1)] }
  return password
end

puts "Please input password length : "
length = gets.to_i
puts  "Generate a new password : #{generate_password(length)}"
