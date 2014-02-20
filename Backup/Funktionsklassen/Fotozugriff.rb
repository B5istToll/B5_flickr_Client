#Diese Klasse enthält Methoden mit denen wir in unserem Client auf die Fotos zugreifen.

class Fotozugriff

	#----------------- Authentication --------------------------------------

	FlickRaw.api_key="cf109011ace10a7068593a1cac50c3cb"
	FlickRaw.shared_secret="9db5e517217ee3f0"


	#--------------- Anmelden mit Benutzer ---------------------------------

	flickr.access_token = "72157640916575304-a2ef387d72b02f04"
	flickr.access_secret = "20d289d72c262b40"

	#--------- Holt sich alle Bild Ids vom dem Benutzer -------------------

	def getAllPictures()
	@photos = flickr.photos.search(:user_id => "117480828@N08")

	#puts @photos.count # ausgabe in konsole um zugucken ob er was gefunden hat

	@photo_id = []

		 @photos.each do |p|                    
		 @photo_id.push p.id
		 end

	  return @photo_id 
	end


	#---------Informationen für die einzelnen Bilder Speichern-------

	def getPictureInfo()
	  @photo_id = getAllPictures()
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

end