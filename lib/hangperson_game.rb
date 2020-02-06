class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
   
    if  letter == nil || letter.empty? || !(/[[:alpha:]]/.match?(letter))

      raise ArgumentError, "No guess. Give me a letter"
    else
      letter.downcase!
      if word.include? letter
        # print("included")
        if !@guesses.include? letter
          @guesses = @guesses + letter
        else 
          false
        end
      else
        #print("Not include")
        if !wrong_guesses.include? letter
          @wrong_guesses = @wrong_guesses + letter
        else
          false
        end
      end
      
    end  
  end
  
  def check_win_or_lose 
    chars = @word.split("")
   
    return "lose".to_sym if @wrong_guesses.split("").length >= 7
    chars.each {|letter| 
      # puts letter
      return "play".to_sym if !@guesses.include? letter
    }
    return "win".to_sym
  end  

  def word_with_guesses
    
    chars = @word.split("")
    displayed = ""
    chars.each { |letter| 
    
    if @guesses.include? letter
      displayed = displayed + letter
    else
      displayed = displayed + "-"
    end
    }
    
    return displayed


  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end


