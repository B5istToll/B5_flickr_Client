=begin
Autor: Markus Orlikowski, Waldemar Kowalenko
Datum: 01/2014
Beschreibung : Diese Klasse enthält Methoden mit denen wir in unserem Client auf die Fotos zugreifen.
=end

class Fotozugriff

	#Liefert die NSID des Benutzers
	@authObj
	
	
	def initialize()
		@authObj = Authentifizierung.new()
	end

	#--------- Holt sich alle Bild Ids vom dem Benutzer -------------------
	def getPhotos()
	@photos = flickr.photos.search(:user_id => @authObj.getUserID())

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

<<<<<<< HEAD
  photo_path=pictureLink
  flickr.upload_photo photo_path, :title => title, :description => description

	  photo_path=pictureLink
	  flickr.upload_photo photo_path, :title => title, :description => description
=======
	  photo_path=pictureLink
	  flickr.upload_photo photo_path, :title => title, :description => description
	  redirect "/gallery"

	end
>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c

	end

<<<<<<< HEAD

	#-----------------Bild Löschen--------------------------

	def deletePicture(photoId)

	  flickr.photos.delete(:photo_id => photoId)
=======
	#-----------------Bild Löschen--------------------------

	def deletePicture(photoId)

	  flickr.photos.delete(:photo_id => photoId)

	end
>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c

	end

<<<<<<< HEAD

	#---------------Alben Holen-----------------------------

	def getPhotosets()

	  @Photosets = flickr.photosets.getList(:user_id => @authObj.getUserID())
=======
	#---------------Alben Holen-----------------------------

	def getPhotosets()

	  @Photosets = flickr.photosets.getList(:user_id => @authObj.getUserID())

	  return @Photosets
	end
>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c

	  return @Photosets
	end

<<<<<<< HEAD

	#---------------Alben Bilder Holen-----------------------------

	def getPhotosetPhotos(photosetId)

	  @photosetPhotos = flickr.photosets.getPhotos(:photoset_id => photosetId)
=======
	#---------------Alben Bilder Holen-----------------------------

	def getPhotosetPhotos(photosetId)

	  @photosetPhotos = flickr.photosets.getPhotos(:photoset_id => photosetId)

	  return @photosetPhotos
	end
>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c

	  return @photosetPhotos
	end

<<<<<<< HEAD

	#--------------Album erstellen--------------------------

	def createPhotoset(title,primaryPicture,description)

	  flickr.photosets.create(:title => title, :primary_photo_id => primaryPicture, :description => description)
=======
	#--------------Album erstellen--------------------------

	def createPhotoset(title,primaryPicture,description)

	  flickr.photosets.create(:title => title, :primary_photo_id => primaryPicture, :description => description)

	end
>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c

	end

<<<<<<< HEAD

	#----------Bild aus Album löschen------------------------

	def removePictureFromPhotoset(photosetid,photoId)

	  flickr.photosets.removePhoto(:photoset_id => photosetid,:photo_id => photoId)
=======
	#----------Bild aus Album löschen------------------------

	def removePictureFromPhotoset(photosetid,photoId)

	  flickr.photosets.removePhoto(:photoset_id => photosetid,:photo_id => photoId)

	end
>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c

	end

<<<<<<< HEAD

	#--------------Album löschen-----------------------------

	def deletePhotoset(photosetid)

	  flickr.photosets.delete(:photoset_id => photosetid)
=======
	#--------------Album löschen-----------------------------

	def deletePhotoset(photosetid)

	  flickr.photosets.delete(:photoset_id => photosetid)

	end
>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c

	end

<<<<<<< HEAD

	#--------------Bild zum Album hinzufügen-----------------

	def addPhotoToPhotoset(photosetid,photoId)

	  flickr.photosets.addPhoto(:photoset_id => photosetid,:photo_id => photoId)

=======
	#--------------Bild zum Album hinzufügen-----------------

	def addPhotoToPhotoset(photosetid,photoId)

	  flickr.photosets.addPhoto(:photoset_id => photosetid,:photo_id => photoId)

>>>>>>> e3760649798be39b92eaf5238f0c9ece143ddd2c
	end

end
