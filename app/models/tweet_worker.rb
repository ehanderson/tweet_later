class TweetWorker
  include Sidekiq::Worker

# def oauth_consumer
#   raise RuntimeError, "You must set TWITTER_KEY and TWITTER_SECRET in your server environment." unless ENV['TWITTER_KEY'] and ENV['TWITTER_SECRET']
#   @consumer ||= OAuth::Consumer.new(
#     ENV['TWITTER_KEY'],
#     ENV['TWITTER_SECRET'],
#     :site => "https://api.twitter.com"
#   )
# end

# def request_token
#   if not session[:request_token]
#     # this 'host_and_port' logic allows our app to work both locally and on Heroku
#     host_and_port = request.host
#     host_and_port << ":9393" if request.host == "localhost"

#     # the `oauth_consumer` method is defined above
#     session[:request_token] = oauth_consumer.get_request_token(
#       :oauth_callback => "http://#{host_and_port}/auth"
#     )
#   end
#   session[:request_token]
  
# end


  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    @twitter_user  = tweet.user

  # # the `request_token` method is defined in `app/helpers/oauth.rb`
  # access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # # our request token is only valid until we use it to get an access token, so let's delete it from our session
  # session.delete(:request_token)
  # # at this point in the code is where you'll need to create your user account and store the access token
  
  # @twitter_user= User.find(session[:user])
  p @twitter_user
  begin  

    @twitter_client = Twitter::Client.new(
      oauth_token: @twitter_user.oauth_token,
      oauth_token_secret: @twitter_user.oauth_secret)

    @twitter_client.update(params[:tweet])
      erb :success, layout: false
  rescue Twitter::Error
      erb :fail
   end   
  # p access_token
  # begin  

  # twitter_client = Twitter::Client.new(
  #   oauth_token: access_token.oauth_token,
  #   oauth_token_secret: access_token.oauth_secret)

  # twitter_client.update(params[:tweet])

  # rescue Twitter::Error

  # end

  #   # set up Twitter OAuth client here
  #   # actually make API call
  #   # Note: this does not have access to controller/view helpers
  #   # You'll have to re-initialize everything inside here
  end
end
