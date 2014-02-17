require 'flickraw'
require 'sinatra'
require 'erb'

#----------------- Authentication --------------------------------------

FlickRaw.api_key="cf109011ace10a7068593a1cac50c3cb"
FlickRaw.shared_secret="9db5e517217ee3f0"


#--------------- Anmelden mit Benutzer ---------------------------------

flickr.access_token = "72157640916575304-a2ef387d72b02f04"
flickr.access_secret = "20d289d72c262b40"


#--------- Holt sich alle Bild Ids vom dem Benutzer -------------------

def getPhotos()
@photos = flickr.photos.search(:user_id => "117480828@N08")

#puts @photos.count # ausgabe in konsole um zugucken ob er was gefunden hat

@photo_id = []

     @photos.each do |p|                    
	 @photo_id.push p.id
     end

  return @photo_id 
end


#---------Informationen für die einzelnen Bilder Speichern-------

def getPhotosInfos()
  @photo_id = getPhotos()
  @infos = []

    @photo_id.each do |pi|            
      @infos.push  flickr.photos.getInfo(:photo_id => pi)  	 
    end 

  return @infos
end


#-----------------Bild hochladen------------------------

def uploadPicture(title,pictureLink,description)

  photo_path=pictureLink
  flickr.upload_photo photo_path, :title => title, :description => description
  redirect "/Gallery"

end


#-----------------Bild Löschen--------------------------

def deletePicture(photoId)

  flickr.photos.delete(:photo_id => photoId)

end


#--------------Sinatra----------------------------------

get "/Login" do
  erb :login
end


# Zeigt die Gallery vom Benutzer an
get "/Gallery" do
  @photosInfos = getPhotosInfos()
    erb :gallery
end

# 
get "/Album" do
 puts "Album"
end


# Einzelne Bilder anzeigen in Groß
get "/Photo/:photoid" do
  @photo = flickr.photos.getInfo(:photo_id => "#{params[:photoid]}")
   erb :photo
end


# Formular für Bilder Hochladen
get "/Upload" do
 erb :upload
end


# Formular für Bilder Hochladen
get "/Deleted/:photoid" do
 deletePicture("#{params[:photoid]}")
 @message="Picture is deleted"
 erb :response
end


# Bild vom Formular wird auf flickr Hochgeladen
post "/Upload" do
 @title = params[:title]
 @pictureLink = params[:pictureLink][:tempfile]
 @description = params[:description]

 uploadPicture(@title,@pictureLink,@description)

 redirect "/Gallery"
end


