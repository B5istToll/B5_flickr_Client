# hier sollte eigentlich die funktionen rein aus der
# sinatra datei klappt aber net da ruby einfach
# scheisse kompliziert ist wenn man mit mehreren dateien arbeitet

class Clienthandling 

################## Authentication ################################

FlickRaw.api_key="cf109011ace10a7068593a1cac50c3cb"
FlickRaw.shared_secret="9db5e517217ee3f0"

########### Anmelden mit Benutzer ################################

#flickr.access_token = "72157639387811345-6a080db415bc35da"
#flickr.access_secret = "03140de3bcfd73bf"

flickr.access_token = "72157640916575304-a2ef387d72b02f04"
flickr.access_secret = "20d289d72c262b40"


######### Holt sich alle Bilder vom dem Benutzer #################
def getPhotos()
@photos = flickr.photos.search(:user_id => "117480828@N08")

puts @photos.count # ausgabe in konsole um zugucken ob er was gefunden hat

@photo_id = []

     @photos.each do |p|                    
	 @photo_id.push p.id
     end

  return @photo_id 
end

# Ein unabhängige Ausgabe
puts "getPhots"
puts getPhotos()

##################### Ein Bild auslesen #########################
=begin

info = flickr.photos.getInfo(:photo_id => "11729746393")
puts info['server']
puts info['farm']
puts info['secret']


photoid = "11729746393"
serverid = info['server']
farmid = info['farm']
secret = info['secret']

# @picurl = "http://farm#{farmid}.staticflickr.com/#{serverid}/#{photoid}_#{secret}_m.jpg"
# http://farm3.staticflickr.com/2832/11729746393_f63f4c3305_m.jpg

puts @picurl

=end


#------  Urls für die Bilder erstellen -------------------------
def getPhotosUrls()
  @photo_id = getPhotos()
  @infos = []

    @photo_id.each do |pi|            
      @infos.push  flickr.photos.getInfo(:photo_id => pi)  	 
    end 


  @picurls = []
   @infos.each do |i|            
     photoids = i['id']
     serverids = i['server']
     farmids = i['farm']
     secrets = i['secret']  	 
     @picurls.push "http://farm#{farmids}.staticflickr.com/#{serverids}/#{photoids}_#{secrets}_m.jpg"
   end 

  return @picurls
end


#----------------------------------------------------------------

end # Ende der Klasse