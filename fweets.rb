require 'sinatra/base'
require 'twitter'
require 'rss'

class Fweets < Sinatra::Base
  get '/tweets/:user_id' do
    user = params[:user_id]

    content_type "application/rss+xml; charset=utf-8"
    tweets = Twitter.user_timeline(user)
    rss = RSS::Maker.make("2.0") do |maker|
      maker.channel.author = user
      maker.channel.updated = Time.now.to_s
      maker.channel.title = "@#{user} tweets"
      maker.channel.description = "@#{user} tweets"
      maker.channel.link = "http://twitter.com/#{user}"

      tweets.each do |tweet|
        maker.items.new_item do |item|
          item.link = "http://twitter.com/#{tweet.from_user}/status/#{tweet.id}"
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
