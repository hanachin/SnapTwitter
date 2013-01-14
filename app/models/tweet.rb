class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :id_str, :media_url, :raw, :text, :tweet_created_at
  validates_presence_of :id_str, :raw, :text, :tweet_created_at
end
