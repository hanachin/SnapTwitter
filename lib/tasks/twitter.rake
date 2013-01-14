require 'tweetstream'
require 'net/http'
require 'uri'

namespace :twitter do
  task importer: :environment do
    TweetStream.configure do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
      config.auth_method = :oauth
    end
    client = TweetStream::Client.new
    client.track(ENV['HASH_TAG']) do |status|
      params = {
        'auth' => ENV['AUTH'],
        'screen_name'   => status.user.screen_name,
        'tweet[id_str]' => status.id.to_s,
        'tweet[raw]'    => status.to_json.to_s,
        'tweet[text]'   => status.text.gsub(ENV['HASH_TAG'], '').strip,
        'tweet[tweet_created_at]' => status.created_at.to_s
      }
      Net::HTTP.post_form(URI.parse(ENV['TWEETS_URL']), params)
    end
  end
end
