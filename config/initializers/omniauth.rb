require 'omniauth/strategies/snapwhim'

Rails.application.config.middleware.use OmniAuth::Builder do
  app_id     = 'a79adc1fbbbddc398983f6f10cc51148572d9e3ca3f9ae25207f40de625816c3'
  app_secret = 'f25c2c9687b34d8e9aebdfb2e8b5492c6500098a93c042e36d5325ad06841dda'
  provider :snapwhim, app_id, app_secret
end
