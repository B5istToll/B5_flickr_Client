require 'flickraw'


FlickRaw.api_key= "88b3faf325e25878ff6c6c6a0d616fc7"
FlickRaw.shared_secret= "48f5f79faa401c9f"


token = flickr.get_request_token
auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

puts "Open this url in your process to complete the authication process : #{auth_url}"
puts "Copy here the number given when you complete the process."
verify = "437-160-269"  #gets.strip

begin
  flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
  login = flickr.test.login
  puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
rescue FlickRaw::FailedResponse => e
  puts "Authentication failed : #{e.msg}"
end
#photos = flickr.photos.search(:user_id => '12864272@N02') # id aus dem Browser 12864272@N02


=begin
# Diese Werte erhält man direkt von flickr
FlickRaw.api_key="88b3faf325e25878ff6c6c6a0d616fc7" # Ist ein fixer Wert der pro Programm einmal vergeben wird. Er ist immer gleich
FlickRaw.shared_secret="48f5f79faa401c9f" # Ist ein fixer Wert der pro Programm einmal vergeben wird. Er ist immer gleich


reqToken = flickr.get_request_token()

# Holt die URI für die Abfrage an den Benutzer zur Genehmigung auf der flickr- Homepage
auth_url = flickr.get_authorize_url(reqToken['oauth_token'], :perms => 'delete')

# Öffnet die URI im Browser für die Genehmigung
#Launchy.open(auth_url)

verify = "437-160-269".strip()

# --- an diesem Punkt hat der Nutzer alles abgeschlossen -----

begin

  flickr.get_access_token(reqToken['oauth_token'], reqToken['oauth_token_secret'], verify)

#Testet, ob das Anmelden erfolgreich gewesen ist und zeigt dann als Beweis den Benutzernamen an
  loginInfo = flickr.test.login
  puts(loginInfo.username)

rescue FlickRaw::FailedResponse => eObj
  puts "Authentifizierung ist fehlgeschlagen: #{eObj.msg}"
end
=end
