get '/' do
  erb :index

end

get '/sign_in' do
      #   <p>
      #   <strong>token:</strong> <%= @access_token.token %><br>
      #   <strong>secret:</strong> <%= @access_token.secret %><br>
      # </p>
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
  # session.clear
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  # at this point in the code is where you'll need to create your user account and store the access token
  
  @user = User.create(username: @access_token.params[:screen_name], 
                    oauth_token: @access_token.params[:oauth_token],
                    oauth_secret: @access_token.params[:oauth_token_secret])
  session[:user] = @user.id
  erb :index
end

post '/status/create_tweet' do
  user = User.find(session[:user])
  tweet_to_create = params[:tweet]
  delay_time = params[:delay_post]
  jid = user.tweet(tweet_to_create)
  {jid: jid}.to_json


  
end

get '/status/:jid' do
  if job_is_complete(jid)
  # if job_id has been completed, send back "Posted"
  else
  # else send back "we haven't posted it yet"
  end
end






# post '/' do
#   @twitter_user= User.find(session[:user])
#   p @twitter_user
#   begin  

#     @twitter_client = Twitter::Client.new(
#       oauth_token: @twitter_user.oauth_token,
#       oauth_token_secret: @twitter_user.oauth_secret)

#     @twitter_client.update(params[:tweet])
#       erb :success, layout: false
#   rescue Twitter::Error
#       erb :fail
#    end   

# end
