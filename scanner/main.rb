# Only worked after:
# export NO_PROXY=localhost,127.0.0.0/8 
# export no_proxy=localhost,127.0.0.0/8 
#
require 'selenium-webdriver'
require 'net/http'
require 'uri'
require 'mongoid'
require './site.rb'


def takeScreenShot(id, url)
	width = 1024
	height = 728
	driver = Selenium::WebDriver.for :firefox
	driver.navigate.to url
	driver.execute_script %Q{
	  window.resizeTo(#{width}, #{height});
	}

	thumbnail = driver.save_screenshot('../reflexio/public/screenshots/' + id + '.png')
	driver.quit
	return thumbnail
end

def getResponseCode(url)
	uri = URI.parse(url)
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)
	
	return http.request(request).code
end

def getNextSite()
	site = Site.where(state: 'Pending').first
	return site 
end

Mongoid.load!('../reflexio/config/mongoid.yml', :development)

while (true)
   site = getNextSite()
   unless site.nil? 
       start = Time.now()
       begin
           site.response_code = getResponseCode(site.url)
           site.response_time = Time.now() - start
           unless site.response_code == '200'
               site.screenshot = takeScreenShot(site._id, site.url)
               site.status = 'Success'
           end
       rescue SocketError
           site.status = 'Failed'
       end
       site.state = 'Idle'
       site.timestamp = Time.now
       site.save
   end
end
