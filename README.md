# Sinatra Tumblr OAuth Example

This is an example Sinatra app to demonstrate how to do the Tumblr OAuth flow.

## Setup

You'll need Ruby 2.7.5 (I recommend [`rvm`](https://rvm.io)!) and `bundler` to complete the setup.

1. Install the gems: `bundle install`
1. Rename the `.env.sample` to `.env`: `mv .env.sample .env`
1. Populate the `.env` with your consumer key & secret: [instructions from Tumblr](https://www.tumblr.com/docs/en/api/v2#what-you-need)
  * Your Tumblr API application will need to use `http://localhost:4567/tumblr/callback` as the callback URL.

## Running the example

Running the example is easy: `ruby app.rb`!

If you plan on making changes, use `rerun 'ruby app.rb'` to ✨ automagically ✨ re-run the app when your code changes ([more info](http://sinatrarb.com/faq.html#reloading)).

From there, go to `http://localhost:4567/tumblr/auth` to run the OAuth authorization!

## Contributing

If you get an error, please feel free to file [an issue](https://github.com/andrewjkerr/sinatra_tumblr_oauth_example/issues/new).

Otherwise, I don't expect any changes to be made here but PRs are welcome if they're really needed!