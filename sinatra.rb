#! /usr/bin/env ruby

require 'flickraw'
require 'sinatra'
require 'erb'
require_relative('Funktionsklassen/Fotozugriff')
require_relative('Funktionsklassen/Authentifizierung')

# --- Initialisieren ------------------------------------
# Objekt für den Umgang mit den Fotografien und der Gallerie ------------
foto = Fotozugriff.new()
authObj = Authentifizierung.new()
# Ruft den Autorisierungsprozess auf
authObj.compute()

#----------------- Authentication --------------------------------------

FlickRaw.api_key= authObj.getFlickrApiKey()
FlickRaw.shared_secret= authObj.getFlickrApiSecret()


#--------------- Anmelden mit Benutzer ---------------------------------

flickr.access_token = authObj.getFlickrAccesstoken()
flickr.access_secret = authObj.getFlickrAccessSecret()





#--------------Sinatra----------------------------------

get "/login" do
  erb :login
end


# Zeigt die Gallery vom Benutzer an
get "/gallery" do
  @photosInfos = foto.getPhotosInfos()
    erb :gallery
end


# Zeigt die Alben vom Benutzer an 
get "/photosets" do
 @photosets = foto.getPhotosets()
  erb :album
end


# Einzelne Bilder anzeigen in Groß
get "/photoset/:photosetid" do
  @photosetPhotos = foto.getPhotosetPhotos("#{params[:photosetid]}")
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


# Formular für Album erstellen
get "/create_photoset" do
 @photosInfos = foto.getPhotosInfos()
 erb :create_photoset
end


# Album aus Formular wird erstellt
post "/create_photoset" do
 @title = params[:title]
 @primaryPicture = params[:primaryPicture]
 @description = params[:description]
 foto.createPhotoset(@title,@primaryPicture,@description)
 redirect "/photosets"
end


# Bild aus Album entfernen
get "/remove/:photosetid/:photoid"  do
 foto.removePictureFromPhotoset("#{params[:photosetid]}","#{params[:photoid]}")
 @message="Picture is removed"
 erb :response
end


# Album Löschen
get "/delete_photoset/:photosetid"  do
 foto.deletePhotoset("#{params[:photosetid]}")
 @message="Photoset is removed"
 erb :response
end


# Bilder zum hinzufügen für die Alben anzeigen
get "/add/:photosetid"  do
  @photosInfos = foto.getPhotosInfos()
  @photosetId = "#{params[:photosetid]}"
    erb :add
end


# Bild zum Album hinzufügen
get "/add/:photosetid/:photoid"  do
  foto.addPhotoToPhotoset("#{params[:photosetid]}","#{params[:photoid]}")
    redirect "/photoset/#{params[:photosetid]}"
end
