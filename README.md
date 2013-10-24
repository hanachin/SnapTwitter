# How to setup

1. Register your application from [app management console](http://your-app.example.com/oauth/applications/)
  - set callback url `http://your-app.example.com/auth/snapwhim/callback`
2. Register twitter application from [here](https://dev.twitter.com/apps/new)

## local run
### in your app dir
- `bundle exec rails s`

### in snaptweet dir
- copy `.env.sample` to `.env` then tweak each variable
- `bundle exec rails s -p 5000`
- `bundle exec rake twitter:importer`

## setup web dyno
1. `heroku create la-snap`
2. `heroku config:set HASH_TAG=#snap OAUTH_PROVIDER_SITE=http://your-app.example.com/ APP_ID=YOUR_APP_ID APP_SECRET=YOUR_APP_SECRET AUTH=himitsu -a la-snap`
3. `heroku addons:add heroku-postgresql:dev -a la-snap`
4. `git push heroku master`
5. `heroku run bundle exec rake db:migrate -a la-snap`
6. `heroku addons:add papetrail -a la-snap`
7. `heroku addons:add newrelic -a la-snap`

## setup twitter watcher dyno
1. `heroku create la-snap-watcher --remote heroku-watcher`
2. `heroku config:set HASH_TAG=#snap TWEETS_URL=http://la-snap.herokuapp.com/tweets/ TWITTER_CONSUMER_KEY=YOUR_TWITTER_CONSUMER_KEY TWITTER_CONSUMER_SECRET=YOUR_TWITTER_CONSUMER_SECRET TWITTER_OAUTH_TOKEN=YOUR_TWITTER_OAUTH_TOKEN TWITTER_OAUTH_TOKEN_SECRET=YOUR_TWITTER_OAUTH_TOKEN_SECRET -a la-snap-watcher`
3. `git push heroku-watcher master`
4. `heroku ps:scale web=0 twitter=1 -a la-snap-watcher`
5. `heroku addons:add papetrail -a la-snap-watcher`
6. `heroku addons:add newrelic -a la-snap-watcher`