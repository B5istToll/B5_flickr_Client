=begin
Autor : Markus Orlikowski
Datum : 17.01.2014
Bedeutung: Diese Klasse ermöglicht den Login bei flickr auf ganz einfache Weise
=end

require 'flickraw'
require 'launchy'

class Authentifizierung
	  # Diese Werte erhält man direkt von flickr. Sie sind fix
	  @flickrApiKey
	  @flickrApiSecret

	  #Diese Werte bekommt man durch Methodenanfragen
	  @flickrAccessToken
	  @flickrAccessSecret
	  @AuthURL
	  @authTokenFull
	  @userID

	def initialize()
		# Diese Werte erhält man direkt von flickr
		FlickRaw.api_key="88b3faf325e25878ff6c6c6a0d616fc7" # Ist ein fixer Wert der pro Programm einmal vergeben wird. Er ist immer gleich
		FlickRaw.shared_secret="48f5f79faa401c9f" # Ist ein fixer Wert der pro Programm einmal vergeben wird. Er ist immer gleich
		@flickrApiKey = "88b3faf325e25878ff6c6c6a0d616fc7"
		@flickrApiSecret = "48f5f79faa401c9f"
		
		compute()

		#@authTokenFull = flickr.auth.getFullToken()
		#@userID = @authTokenFull.user.nsid
	end
	
	#Nach dem Aufruf von compute soll die Anmeldung stehen
	#Sie fasst den Prozess in einer Methode zusammen
	def compute()
		reqToken = flickr.get_request_token()
		@AuthURL = flickr.get_authorize_url(reqToken['oauth_token'], :perms => 'delete')
		openURI(@AuthURL)
		verify = gets.strip() # Code von der Webseite nach der Genehmigung

		begin
		  flickr.get_access_token(reqToken['oauth_token'], reqToken['oauth_token_secret'], verify)
		  login = flickr.test.login
		  puts "Sie sind nun angemeldet als #{login.username} mit Token #{flickr.access_token} und 'Secret' #{flickr.access_secret}"
		  @flickrAccessToken = flickr.access_token
		  @flickrAccessSecret = flickr.access_secret
		  
		rescue FlickRaw::FailedResponse => e
		  puts "Authentifikation gescheitert : #{e.msg}"
		end
	end

  def getFlickrApiKey()
    return @flickrApiKey
  end

  def getFlickrApiSecret()
    return @flickrApiSecret
  end

	def getFlickrAccesstoken()
	  @flickrAccessToken
	end
	
	def getFlickrAccessSecret()
	  @flickrAccessSecret
	end

  def getUserID()
    return @userID
  end

	#öffnet die URI für die Genehmigung im Standardbrowser
	def openURI(uri)
    Launchy.open(uri)
	end
	

end


#authObj = Authentifizierung.new()
#puts(authObj.getUserID())