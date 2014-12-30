#!/bin/env ruby
require 'rubygems'
require 'open-uri'

File.open("test.log", "r:iso-8859-1:utf-8") do |file|
	p String.try_convert(file.read)
end