#!/bin/env ruby
# -- parse old version log
# $remote_addr $request_uri request_length:$request_length $http_device "$time_iso8601"  "$msec" "$time_local" bytesend:$bytes_sent $request_length $request_method "$uri" "$args" body:"$request_body" $status body_bytes_send:$body_bytes_sent $request_time "$http_user_agent"';

require 'rubygems'
require 'uri'

# read log file and return an array about device_info
def read_logfile (filename)
  File.open(filename, "r") do |file|
    line_num = 0
    fields = "market_id, guid, app_id, app_ver, os_name, android_ver, vendor, model, screen_des, screen_dpi, language, timezone, imei, imsi, mac"
    values = ""
    sql = "INSERT INTO device_infos(#{fields}) VALUES"

    file.each_line do |line|
      device_info = device_info(line.to_s)
      line_num = line_num + 1
      if !device_info.nil?
        begin
          values << "(" << make_to_sql(device_info) <<"),"
          sql << values
          if line_num % 1000 == 0
            sql << ";"
            sql.gsub!(",;", ";")
            puts sql
            value = ""
          else

          end
        rescue
          puts "#{line_num} ERROR to make_to_sql : #{device_info}"
        end
      else
        puts line_num
        puts "#{line_num} --------- parse device_info fail ---------"
      end
    end
  end
end

# change hex string to normal string
def hex_to_s (str)
  
end

# split header info out
def device_info (line)
  reg1 = /request_length:\d{1,}\ /
  reg2 = /\ \"\d\d\d\d\-\d\d\-\d\dT\d\d\:\d\d\:\d\d\+\d\d\:\d\d\"/
  n = line.index(reg1)
  m = line.index(reg2)
  if(!n.nil? and !m.nil?)
    n = n + line.match(reg1).to_s.length
    m = m -1
    # cut string from n to m
    if n >= m
      nil
    else
      device_info = line[n..m]
      #puts device_info
      return device_info
    end
  else
    nil
  end
end

def make_to_sql (device_info)
  device_info = URI.unescape(device_info.gsub!(/\\x/,'%').force_encoding('UTF-8'))
  reg = /\"\ \"/
  #puts "device_info : #{device_info}"
  if !device_info.index(reg).nil? 
    device_info.gsub!(reg,"\",\"")
  else
    device_info
  end
end

# read filename from console parameters
filename = ARGV[0]
if filename.nil?
  puts "Usage : ruby parse_old_log.rb  log_filename"
else
  read_logfile filename
end