require 'omniauth/strategies/snapwhim'

Rails.application.config.middleware.use OmniAuth::Builder do
  app_id     = ENV['APP_ID']
  app_secret = ENV['APP_SECRET']
  provider :snapwhim, app_id, app_secret
end
