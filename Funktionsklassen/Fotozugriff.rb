#Diese Klasse enthält Methoden mit denen wir in unserem Client auf die Fotos zugreifen.

class Fotozugriff

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

  return @photosetPhotos
end


#--------------Album erstellen--------------------------

def createPhotoset(title,primaryPicture,description)

  flickr.photosets.create(:title => title, :primary_photo_id => primaryPicture, :description => description)

end


#----------Bild aus Album löschen------------------------

def removePictureFromPhotoset(photosetid,photoId)

  flickr.photosets.removePhoto(:photoset_id => photosetid,:photo_id => photoId)

end


#--------------Album löschen-----------------------------

def deletePhotoset(photosetid)

  flickr.photosets.delete(:photoset_id => photosetid)

end


#--------------Bild zum Album hinzufügen-----------------

def addPhotoToPhotoset(photosetid,photoId)

  flickr.photosets.addPhoto(:photoset_id => photosetid,:photo_id => photoId)

end

end
