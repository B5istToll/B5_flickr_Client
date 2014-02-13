require 'flickraw'
require 'sinatra'
require 'erb'


FlickRaw.api_key="cf109011ace10a7068593a1cac50c3cb"
FlickRaw.shared_secret="9db5e517217ee3f0"


flickr.access_token = "72157639387811345-6a080db415bc35da"
flickr.access_secret = "03140de3bcfd73bf"

PHOTO_PATH='111.png'
# You need to be authentified to do that, see the previous examples.
flickr.upload_photo PHOTO_PATH, :title => "Title", :description => "This is #the description"


