# Only worked after:
# export NO_PROXY=localhost,127.0.0.0/8 
# export no_proxy=localhost,127.0.0.0/8 
#
require 'selenium-webdriver'
require 'net/http'
require 'uri'
require 'mongo_mapper'
require 'mongo'

include MongoMapper::Document

def takeScreenShot(url)
	width = 1024
	height = 728
	driver = Selenium::WebDriver.for :firefox
	driver.navigate.to url
	driver.execute_script %Q{
	  window.resizeTo(#{width}, #{height});
	}

	thumbnail = driver.screenshot_as(:png)
	driver.quit
	return thumbnail
end

def getResponseCode(url)
	uri = URI.parse(url)
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)
	
	return http.request(request).code
end

def getNextSite(db)
	report = Report.where(state => 'Pending').first
	return report
end

def getConnection
	MongoMapper.connection = Mongo::Connection.new
	MongoMapper.database = 'reflexio'
end



