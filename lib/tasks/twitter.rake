require 'tweetstream'
require 'net/http'
require 'uri'

def instagram(url)
  url = url.split('/').last
  "http://instagram.com/p/#{url}/media/?size=m"
end

def yfrog(url)
  url = url.split('/').last
  "http://yfrog.com/#{url}:iphone"
end

def twitpic(url)
  url = url.split('/').last
  "http://twitpic.com/show/large/#{url}"
end

def photozo(url)
  url = url.split('/').last
  "http://photozou.jp/p/img/#{url}"
end

def twipple(url)
  url = url.split('/').last
  "http://p.twipple.jp/show/large/#{url}"
end

def movapic(url)
  url = url.split('/').last
  "http://image.movapic.com/pic/m_#{url}.jpeg"
end

def image_url(tweet)
  return tweet.media[0][:media_url] if tweet.media && tweet.media[0] && tweet.media[0][:media_url]

  tweet.urls.map {|u|
    case url = u.expanded_url
    when /twitpic/
      twitpic(url)
    when /instagr.am/
      instagram(url)
    when /yfrog.com/
      yfrog(url)
    when /photozou.jp/
      photozo(url)
    when /p.twipple.jp/
      twipple(url)
    when /movapic.com/
      movapic(url)
    else
      nil
    end
  }.select {|u| u}.first
end

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
        'tweet[tweet_created_at]' => status.created_at.to_s,
        'tweet[media_url]'=> image_url(status)
      }
      Net::HTTP.post_form(URI.parse(ENV['TWEETS_URL']), params)
    end
  end
end
