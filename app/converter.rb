require 'engtagger'

class Tweet
  attr_accessor :array_of_tweets
  def initialize(tweets)
    @tweets = tweets
    @array_of_tweets = []
    @nouns = []
    @verbs = []
    @adjectives = []
    @string = ''
  end

  def original_array
    array = []
    @string = @array_of_tweets.join(" ")
  end

  def convert_tweets_to_array_of_strings
    @tweets.each do |tweet|
      @array_of_tweets << tweet.text
    end
    @array_of_tweets
  end

  def strip_usernames
    # p @string
    @string.gsub!(/[",.\\\n?!]/, '')
  end

  def baaos
    @string.split(" ")
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

  def self.word_frequency

  end

  def determine_parts_of_speech
    tgr = EngTagger.new
    tagged = tgr.add_tags(@array_of_tweets.join(" ").split(" ").join(" "))
    tgr.get_nouns(tagged).each { |word| @nouns << word[0] }
    tgr.get_verbs(tagged).each { |word| @verbs << word[0] }
    tgr.get_adjectives(tagged).each { |word| @adjectives << word[0] }
  end

  def compose_sentence
    @nouns.sample + ' ' + @verbs.sample + ' ' + @adjectives.sample
  end
end
