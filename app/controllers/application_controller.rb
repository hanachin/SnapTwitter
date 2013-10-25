class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :add_wanto

  private

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  end

  def add_wanto(user, tweet)
    app_id     = ENV['APP_ID']
    app_secret = ENV['APP_SECRET']
    client = OAuth2::Client.new(app_id, app_secret, site: ENV['OAUTH_PROVIDER_SITE'])
    access_token = OAuth2::AccessToken.new(client, user.token)
    access_token.post('/api/v1/wantos', params: { title: tweet.text, image_remote_url: tweet.media_url})
  end
end
