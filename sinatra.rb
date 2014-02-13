require 'flickraw'
require 'sinatra'
require 'erb'


get "/index" do
clientObj = Clienthandling.new

puts "urls"
puts clientObj.getPhotosUrls()

#@photos = photos

##@picurls = 
@a = clientObj.getPhotosUrls()
@picurls = []
 @a.each do |p|            
   @picurls.push p	 
 end 
	
puts "index"
puts @picurls

  erb :html
end






