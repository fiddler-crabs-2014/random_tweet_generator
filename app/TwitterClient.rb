require_relative './converter.rb'

module TwitterClient
  require 'twitter'
  require 'open-uri'
  require 'awesome_print'

  def prevent_rate_limiting
    max_attempts = 3
    num_attempts = 0
    follower_ids = client.follower_ids
    begin
      num_attempts += 1
      follower_ids.to_a
    rescue Twitter::Error::TooManyRequests => error
      if num_attempts <= max_attempts
        # NOTE: Your process could go to sleep for up to 15 minutes but if you
        # retry any sooner, it will almost certainly fail with the same exception.
        sleep error.rate_limit.reset_in
        retry
      else
        raise
      end
    end
  end

  def self.create_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['API_KEY']
      config.consumer_secret     = ENV['API_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    client
  end

  def self.get_last_20_tweets(user)
    client = TwitterClient.create_client
    client.user_timeline(user)
  end

end

twitter_handle = ARGV[0]

#Driver / Testing Code:
tweets = TwitterClient.get_last_20_tweets(twitter_handle)
tweets = Tweet.new(tweets)
tweets.convert_tweets_to_array_of_strings
tweets.original_array
tweets.strip_usernames
p tweets.map_counts(tweets.unique_words(tweets.baaos))
# tweets.determine_parts_of_speech
# p tweets.compose_sentence
# tweets.compose_sentence
# basic code to pull tweets from text
# tweet_array =[]
# bucks_timeline = @client.user_timeline('officialjaden')
# bucks_timeline.each do |tweet|
#   tweet_array << tweet.text
# end

# p tweet_array

# # print one tweet
# tweet = client.status(456957468300414976)
# puts tweet.methods
