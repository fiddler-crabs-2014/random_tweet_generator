require 'twitter'
require 'open-uri'
require 'awesome_print'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['API_KEY']
  config.consumer_secret     = ENV['API_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

MAX_ATTEMPTS = 3
num_attempts = 0
follower_ids = client.follower_ids
begin
  num_attempts += 1
  follower_ids.to_a
rescue Twitter::Error::TooManyRequests => error
  if num_attempts <= MAX_ATTEMPTS
    # NOTE: Your process could go to sleep for up to 15 minutes but if you
    # retry any sooner, it will almost certainly fail with the same exception.
    sleep error.rate_limit.reset_in
    retry
  else
    raise
  end
end

# bucks_timeline = client.user_timeline('buckoleary')
# bucks_timeline.each do |tweet|
#   puts tweet.text
# end

tweet = client.status(456957468300414976)
puts tweet.methods
