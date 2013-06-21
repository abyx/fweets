# Fweets: Twitter to RSS to IFTTT Like a Boss

Fweets is a simple server that uses the twitter API in order to create an RSS feed of tweets that can be used to trigger actions on IFTTT.

Some back story about this is available [here](http://www.codelord.net/2013/06/21/do-it-yourself-twitter-triggers-for-ifttt/).

## Installation

Fweets require a bit tech-savviness: we will setup a heroku app to run the server.

  1. Clone this project from GitHub: `git clone https://github.com/abyx/fweets.git`
  2. Create a Twitter application [here](https://dev.twitter.com/apps/new)
  3. Create a heroku app in the cloned project: `heroku create`
  4. Enter your Twitter application's keys as heroku environment variables:
     `heroku config:set TWITTER_CONSUMER_KEY="KEY"`
     `heroku config:set TWITTER_CONSUMER_SECRET="SECRET"`
     `heroku config:set TWITTER_OAUTH_TOKEN="TOKEN"`
     `heroku config:set TWITTER_OAUTH_TOKEN_SECRET="TOKEN_SECRET"`
  5. Deploy to heroku: `git push heroku master`
  6. That's it! RSS feeds that can be used with IFTTT are now avaialbe at http://YOURAPP.herokuapp.com/tweets/username and http://YOURAPP.herokuapp.com/favorites/username

## Disclaimer

Fweets is a quick one-hour hack to scratch my own itch. As you can see from the extremely short code, it does not do any error handling and such. I wouldn't use this for anything more serious than backing up your tweets and similar uses.
