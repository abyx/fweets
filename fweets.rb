require 'sinatra/base'
require 'twitter'
require 'rss'

USER = 'avivby'

class Fweets < Sinatra::Base
  get '/' do
    content_type "application/rss+xml; charset=utf-8"
    tweets = Twitter.user_timeline(USER)
    rss = RSS::Maker.make("2.0") do |maker|
      maker.channel.author = USER
      maker.channel.updated = Time.now.to_s
      maker.channel.title = USER
      maker.channel.description = "@#{USER}"
      maker.channel.link = "http://twitter.com/#{USER}"

      tweets.each do |tweet|
        maker.items.new_item do |item|
          item.link = "http://twitter.com/#{USER}/status/#{tweet.id}"
          item.title = tweet.full_text
          item.description = tweet.full_text
          item.updated = tweet.created_at
          item.guid.content = tweet.id.to_s
          item.author = tweet.from_user
        end
      end
    end

    rss.to_s
  end
end
