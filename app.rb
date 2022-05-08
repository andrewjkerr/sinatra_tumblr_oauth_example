# this gem is to load the .env file with our secrets
require 'dotenv/load'

# the oauth gem
require 'oauth'

# our web framework: sinatra!
require 'sinatra'

# the tumblr client we'll use with our oauth tokens
require 'tumblr_client'

# enable sessions so we can keep track of our oauth information between auth & callback
enable :sessions

# our callback url is gonna be `/tumblr/callback`
CALLBACK_URL = "http://localhost:4567/tumblr/callback"

# create our oauth consumer before any request, if we need to
before do
  @oauth_consumer ||= OAuth::Consumer.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], site: "https://www.tumblr.com")
end

get '/tumblr/auth' do
  # get our request token from the callback URL
  request_token = @oauth_consumer.get_request_token(oauth_callback: CALLBACK_URL)

  # set the token & secret from our request token
  session[:token] = request_token.token
  session[:token_secret] = request_token.secret

  # redirect to the tumblr auth
  redirect request_token.authorize_url(oauth_callback: CALLBACK_URL)
end

get '/tumblr/callback' do
  # to get our request token, we use the session's token & secret
  hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret] }

  # get our request token to request our access token
  request_token = OAuth::RequestToken.from_hash(@oauth_consumer, hash)
  access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier])

  # build the tumblr client
  client = Tumblr::Client.new(
    consumer_key: ENV['CONSUMER_KEY'],
    consumer_secret: ENV['CONSUMER_SECRET'],
    oauth_token: access_token.token,
    oauth_token_secret: access_token.secret,
  )

  # get the user info and print it out to demonstrate it worked! 💯
  JSON.pretty_generate(client.info)
end