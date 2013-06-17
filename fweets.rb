require 'sinatra/base'
require 'twitter'
require 'rss'

class Fweets < Sinatra::Base
  def to_rss(tweets, user, title, link)

    content_type "application/rss+xml; charset=utf-8"
    rss = RSS::Maker.make("2.0") do |maker|
      maker.channel.author = user
      maker.channel.updated = Time.now.to_s
      maker.channel.title = title
      maker.channel.description = title
      maker.channel.link = link

      tweets.each do |tweet|
        maker.items.new_item do |item|
          item.link = "http://twitter.com/#{tweet.from_user}/status/#{tweet.id}"
          text = "@#{tweet.from_user}: #{tweet.full_text}"
          item.title = text
          item.description = text
          item.updated = tweet.created_at
          item.guid.content = tweet.id.to_s
          item.author = tweet.from_user
        end
      end
    end

    rss.to_s
  end

  get '/tweets/:user' do
    user = params[:user]

    to_rss(Twitter.user_timeline(user),
           user,
           "@#{user} tweets",
           "http://twitter.com/#{user}")
  end

  get '/favs/:user' do
    user = params[:user]

    to_rss(Twitter.favorites(user),
           user,
           "@#{user} favorites",
           "http://twitter.com/#{user}/favorites")
  end
end
