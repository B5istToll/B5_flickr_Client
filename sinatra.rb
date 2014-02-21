require 'flickraw'
require 'sinatra'
require 'sinatra/session'
require 'erb'
require_relative('Funktionsklassen/Fotozugriff')
require_relative('Funktionsklassen/Authentifizierung')

# --- Initialisieren --------------------------------------------------------
set :session_fail, '/login'
set :session_secret, 'JanDuhr110'

foto = Fotozugriff.new()
authObj = Authentifizierung.new()
# Ruft den Autorisierungsprozess auf

#--------------Sinatra----------------------------------
get "/" do
	session!
	redirect "/gallery"
end

get "/login" do
	if session?
		redirect "/"
	else
  		erb :login
  	end	
end

post '/login' do
  if params[:Name]
    session_start!
    authObj.compute()
    session[:name] = params[:Name]
    redirect '/'
  else
    redirect '/login'
  end
end

get '/logout' do
  session_end!
  redirect '/'
end

# Zeigt die Gallery vom Benutzer an
get "/gallery" do
	if session?
  		@photosInfos = foto.getPhotosInfos()
    	erb :gallery
    else
    	redirect "/"
    end	
end


# Zeigt die Alben vom Benutzer an 
get "/photosets" do
if session?
 @photosets = foto.getPhotosets()
  erb :album
  else
    	redirect "/"
    end	
end


# Einzelne Bilder anzeigen in Groß
get "/photoset/:photosetid" do
if session?
  @photosetPhotos = foto.getPhotosetPhotos("#{params[:photosetid]}")
   erb :album_gallery
   else
    	redirect "/"
    end	
end


# Einzelne Bilder anzeigen in Groß
get "/photo/:photoid" do
if session?
  @photo = flickr.photos.getInfo(:photo_id => "#{params[:photoid]}")
   erb :photo
   else
    	redirect "/"
    end	
end


# Bildbeschreibung ändern Formular
get "/edit_photo/:photoid" do
if session?
  @photo = flickr.photos.getInfo(:photo_id => "#{params[:photoid]}")
  erb :edit_photo
   else
    	redirect "/"
    end	
end


# Bild beschreibung wird hochgeladen
post "/edit_photo" do
if session?
 @photoid = params[:photoid]
 @title = params[:title]
 @description = params[:description]

 foto.setPhotoMeta(@photoid,@title,@description)

 redirect "/photo/#{params[:photoid]}"
 else
    	redirect "/"
    end	
end


# Formular für Bilder Hochladen
get "/upload" do
if session?
 erb :upload
 else
    	redirect "/"
    end	
end


# Bild aus dem Stream löschen
get "/deleted/:photoid" do
if session?
 foto.deletePicture("#{params[:photoid]}")
 redirect "/gallery"
 else
    	redirect "/"
    end	
end


# Bild vom Formular wird auf flickr Hochgeladen
post "/upload" do
if session?
 @title = params[:title]
 @pictureLink = params[:pictureLink][:tempfile]
 @description = params[:description]

 foto.uploadPicture(@title,@pictureLink,@description)

 redirect "/gallery"
 else
    	redirect "/"
    end	
end


# Formular für Album erstellen
get "/create_photoset" do
if session?
 @photosInfos = foto.getPhotosInfos()
 erb :create_photoset
 else
    	redirect "/"
    end	
end


# Album aus Formular wird erstellt
post "/create_photoset" do
if session?
 @title = params[:title]
 @primaryPicture = params[:primaryPicture]
 @description = params[:description]
 foto.createPhotoset(@title,@primaryPicture,@description)
 redirect "/photosets"
 else
    	redirect "/"
    end	
end


# Bild aus Album entfernen
get "/remove/:photosetid/:photoid"  do
if session?
 foto.removePictureFromPhotoset("#{params[:photosetid]}","#{params[:photoid]}")
 redirect "/gallery"
 else
    	redirect "/"
    end	
end


# Album Löschen
get "/delete_photoset/:photosetid"  do
if session?
 foto.deletePhotoset("#{params[:photosetid]}")
 redirect "/gallery"
 else
    	redirect "/"
    end	
 
end


# Bilder zum hinzufügen für die Alben anzeigen
get "/add/:photosetid"  do
if session?
  @photosInfos = foto.getPhotosInfos()
  @photosetId = "#{params[:photosetid]}"
    erb :add
    else
    	redirect "/"
    end	
end


# Bild zum Album hinzufügen
get "/add/:photosetid/:photoid"  do
if session?
  foto.addPhotoToPhotoset("#{params[:photosetid]}","#{params[:photoid]}")
    redirect "/photoset/#{params[:photosetid]}"
    else
    	redirect "/"
    end	
end
