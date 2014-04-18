require 'rubygems'
require 'engtagger'
require 'awesome_print'

def word_frequency
 # Input: Big ass array of strings (baaos)
 # Output: Hash(word: frequency)
end

def unique_words(tweets)
  p tweets.uniq
end

def map_counts(array)
  counts = {}
  array.each do |word|
    counts[word.to_sym] = baaos.count(word)
  end
  p counts
end

def compose_sentence
 # Input: WHATEVER
 # Output: sentence string under 140 chars
end

def original_array
  $tweets = []
  File.open("tweet.txt").each do |line|
    $tweets << line.chomp.split(" ")
  end
  p $tweets
end

def strip_usernames
  cleaned_up_tweets = ""
  File.open("tweet.txt").each do |line|
    cleaned_up_tweets << line
  end
  p "before"
  p cleaned_up_tweets
  p "after"
  cleaned_up_tweets.gsub!(/(@\w*)|[",.\\\n?!]|(https?:.*)/, '')
end

def baaos
  strip_usernames.split(" ")
end

#p strip_usernames
# p baaos
# p map_counts(baaos)
# tgr = EngTagger.new
# ap tweet_with_counts = tgr.get_words(tweets)
# unique_words(baaos)
map_counts(unique_words(baaos))




