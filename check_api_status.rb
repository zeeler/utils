#!/bin/env ruby
require 'rubygems'
require 'net/http'

urls = []
# 初始化接口
urls << "http://api.leostat.com/appmaster/init"
# 升级查询接口
urls << "http://api.leostat.com/appmaster/release"
# 日志上报接口
urls << "http://api.leostat.com/appmaster/loguploadable"
# 自定义事件上报接口
urls << "http://api.leostat.com/appmaster/applog"
# 基础事件上报接口
urls << "http://api.leostat.com/appmaster/baselog"
# 应用推荐列表接口
urls << "http://api.leostat.com/appmaster/applockerrecommend"
# 意见反馈接口
urls << "http://api.leostat.com/appmaster/feedback"

urls.each do |url|
	uri = URI(url)
	params = { :flag => "STATUS_TEST" }
	# 监控时间
	start_time = Time.new.to_f * 1000
	uri.query = URI.encode_www_form(params)
	res = Net::HTTP.get_response(uri)
	end_time = Time.new.to_f * 1000

	puts "#{Time.new.localtime} #{res.code} #{res.message} #{res.body.length} #{end_time-start_time} #{url}"
	sleep 2
end