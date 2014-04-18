require 'engtagger'

class Tweet
  attr_accessor :array_of_tweets
  def initialize(tweets)
    @tweets = tweets
    @array_of_tweets = []
    @nouns = []
    @verbs = []
    @adjectives = []
  end

# self. method
  def convert_tweets_to_array_of_strings
    @tweets.each do |tweet|
      @array_of_tweets << tweet.text
    end
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
