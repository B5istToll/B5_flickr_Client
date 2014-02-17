require 'flickraw'
require 'sinatra'
require 'erb'
require './Funktionsklassen/Fotozugriff.rb'


# --- Initialisieren ------------------------------------
# Objekt für den Umgang mit den Fotografien und der Gallerie ------------
foto = Fotozugriff.new


#--------------Sinatra----------------------------------



get "/login" do
  erb :login
end


# Zeigt die Gallery vom Benutzer an
get "/gallery" do
  @photosInfos = foto.getPictureInfo()
    erb :gallery
end

# 
get "/album" do
 puts "Album"
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
 foto.deletePicture("#{params[:photoid]}")
 @message="Picture is deleted"
 erb :response
end


# Bild vom Formular wird auf flickr Hochgeladen
post "/upload" do
 @title = params[:title]
 @pictureLink = params[:pictureLink][:tempfile]
 @description = params[:description]

 foto.uploadPicture(@title,@pictureLink,@description)

 redirect "/gallery"
end


