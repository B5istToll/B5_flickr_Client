require 'flickraw'

FlickRaw.api_key="cf109011ace10a7068593a1cac50c3cb"
FlickRaw.shared_secret="9db5e517217ee3f0"

flickr.access_token = "72157639387811345-6a080db415bc35da"
flickr.access_secret = "03140de3bcfd73bf"

token = flickr.get_request_token
auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

puts "Open this url in your process to complete the authication process : #{auth_url}"
puts "Copy here the number given when you complete the process."
verify = gets.strip

begin
  flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
  login = flickr.test.login
  puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
rescue FlickRaw::FailedResponse => e
  puts "Authentication failed : #{e.msg}"
end

# From here you are logged:
login = flickr.test.login
puts "You are now authenticated as #{login.username}"