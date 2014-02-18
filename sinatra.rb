require 'flickraw'
require 'sinatra'
require 'erb'
require_relative './Funktionsklassen/Fotozugriff.rb'


# --- Initialisieren ------------------------------------
# Objekt für den Umgang mit den Fotografien und der Gallerie ------------
foto = Fotozugriff.new


#----------------- Authentication --------------------------------------

FlickRaw.api_key="cf109011ace10a7068593a1cac50c3cb"
FlickRaw.shared_secret="9db5e517217ee3f0"


#--------------- Anmelden mit Benutzer ---------------------------------

flickr.access_token = "72157640916575304-a2ef387d72b02f04"
flickr.access_secret = "20d289d72c262b40"


#--------- Holt sich alle Bild Ids vom dem Benutzer -------------------

def getPhotos()
@photos = flickr.photos.search(:user_id => "117480828@N08")

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
  redirect "/gallery"

end


#-----------------Bild Löschen--------------------------

def deletePicture(photoId)

  flickr.photos.delete(:photo_id => photoId)

end


#---------------Alben Holen-----------------------------

def getPhotosets()

  @Photosets = flickr.photosets.getList(:user_id => "117480828@N08")

  return @Photosets
end


#---------------Alben Bilder Holen-----------------------------

def getPhotosetPhotos(photosetId)

  @photosetPhotos = flickr.photosets.getPhotos(:photoset_id => photosetId)
puts photosetId  
puts @photosetPhotos['photo']['id'] 
puts "AAAAAAAAAAAAAAAAAAAAAAAA"
@photosetPhotos.each do |p|                    
puts "-----------------"
puts @photosetPhotos
     end

  return @photosetPhotos
end


#--------------Album erstellen--------------------------

def createPhotoset(title,primaryPicture,description)

  flickr.photosets.create(:title => title, :primary_photo_id => primaryPicture, :description => description)

end


#--------------Sinatra----------------------------------

get "/login" do
  erb :login
end


# Zeigt die Gallery vom Benutzer an
get "/gallery" do
  @photosInfos = getPhotosInfos()
    erb :gallery
end


# Zeigt die Alben vom Benutzer an 
get "/photosets" do
 @photosets = getPhotosets()
  erb :album
end


# Einzelne Bilder anzeigen in Groß
get "/photoset/:photosetid" do
  @photosetPhotos = getPhotosetPhotos("#{params[:photosetid]}")
   erb :album_gallery
end


# Einzelne Bilder anzeigen in Groß
get "/photo/:photoid" do
  @photo = flickr.photos.getInfo(:photo_id => "#{params[:photoid]}")
   erb :photo
end


# Formular für Bilder Hochladen
get "/upload" do
 erb :upload
end


# Formular für Bilder Hochladen
get "/deleted/:photoid" do
 deletePicture("#{params[:photoid]}")
 @message="Picture is deleted"
 erb :response
end


# Bild vom Formular wird auf flickr Hochgeladen
post "/upload" do
 @title = params[:title]
 @pictureLink = params[:pictureLink][:tempfile]
 @description = params[:description]

 uploadPicture(@title,@pictureLink,@description)

 redirect "/gallery"
end


# Formular für Album erstellen
get "/create_photoset" do
 @photosInfos = getPhotosInfos()
 erb :create_photoset
end


# Album aus Formular wird erstellt
post "/create_photoset" do
 @title = params[:title]
 @primaryPicture = params[:primaryPicture]
 @description = params[:description]
 createPhotoset(@title,@primaryPicture,@description)
 redirect "/photosets"
end

