#!/bin/env ruby
require 'rubygems'

str = "1.39.15.28 /appmaster/loguploadable request_length:518 \x220011a\x22 \x2212523d07582d3b138296500764fd47bd\x22 \x22appmaster\x22 \x221.0\x22 \x22JLS36C.G7102XXUANA5\x22 \x224.3\x22 \x22samsung\x22 \x22SM-G7102\x22 \x221280x720\x22 \x22320\x22 \x22en\x22 \x22GMT+05:30\x22 \x22352116063179566\x22 \x22404602778396955\x22 \x2234:BE:00:BE:EE:84\x22 \"2014-10-31T10:51:57+05:30\"  \"1414732917.639\" \"31/Oct/2014:10:51:57 +0530\" bytesend:262 518 POST \"/appmaster/loguploadable\" \"-\" body:\"network=2&roaming=0&free_space=2095784&unupload_count=0&battery=66\" 200 body_bytes_send:85 0.024 \"Apache-HttpClient/UNAVAILABLE (java 1.4)\""
reg1 = /request_length:\d{1,}\ /
str1_len = str.match(reg1).to_s.length
reg2 = /\ \"\d\d\d\d\-\d\d\-\d\dT\d\d\:\d\d\:\d\d\+\d\d\:\d\d\"/
n = str.index(reg1) + str1_len 
m = str.index(reg2) -1 
substr = str[n..m]
puts "str [#{str}]"
puts "substr [#{substr}]"
reg3 = /\"\ \"/
substr.gsub!(reg3, "\",\"")
puts substr