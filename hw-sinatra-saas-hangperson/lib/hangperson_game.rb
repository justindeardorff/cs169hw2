class HangpersonGame
  
  attr_reader :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word=word
    @guesses=""
    @wrong_guesses=""
  end  
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    #accepts a letter as guess and returns response
    #returns lose after 7 incorrect guesses
    #rejects repeated letters or non-single letter guesses
    
    if (letter == '') || (letter == nil) || (letter !~ /[a-z]/i)
      raise ArgumentError, "guess must be a single letter"
    end  
    
    letter=letter.downcase
    
    #if invalid, raise arg error and return false
    if (guesses.include? letter) || (wrong_guesses.include? letter)   #check if already guessed
      return false
    end
    
    if(@word.include? letter)  #if the word contains the letter, add it to guesses
        @guesses << letter
    else 
        @wrong_guesses << letter   #otherwise, it's wrong
    end    
    return true
  end
  
  def word_with_guesses
    #returns string that displays hangperson word with guesses
    #word.gsub(/^[#{guesses}]/, '-')
    #word.tr('[^#{guesses}]', '-' )
  end  
  
  def check_win_or_lose
    if wrong_guesses.length>=7
      return :lose
    elsif guesses.length==word.scan(/\w/).uniq.length
      return :win  
    else
      return :play
    end  
  end  
  
end  
