#!/bin/env ruby
module TestApi
	def test_by_url(url)
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
end