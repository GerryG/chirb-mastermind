module Mastermind
  class Game
    def initialize(messenger)
      @messenger = messenger
    end
    
    def start(secret_code=nil, symbols='cgrwy', allowdups=true)
      code_length = 4
      if !secret_code || Integer===secret_code
        code_length = secret_code if secret_code
        secret_code = []
        code_length.times do
          secret_code << symbols[rand(symbols.length)].chr
        end
      end
      @messenger.puts "Welcome to Mastermind!"
      @messenger.puts "Enter guess:"
      if Array===secret_code && secret_code.length == 4
        if @mark && @mark != 'bbbb'
          raise "Game already in progress"
        end
        @secret = secret_code
        @guesses = 0
        @hash = {}
        #maxchar = 'f' #'a'.succ(symbols)
        secret_code.each do |s|
          raise "Code element range #{s}" if s.length != 1 #||
                                             #s < 'a' || s > maxchar
          was = @hash[s] || 0
          raise "Duplicate code element #{s}" if !allowdups && was 
          @hash[s] = was+1
        end
      else
         raise "Bad code #{secret_code.to_s}"
      end
    end
    
    def over?
      @mark == 'bbbb'
    end

    def secret
      @messenger.puts "Code: #{@secret}"
    end

    def guess(guess)
      if Array===guess && guess.length == 4
        b=''; w=''
        hash = @hash.dup
        @guesses += 1
        @messenger.puts "Guess number #{@guesses}"
        for i in 0..3
          g = guess[i]
          hg = hash[g] || 0
          if hg > 0
            hash[g] -= 1
            g == @secret[i] ?  b += 'b' : w += 'w'
          end
        end
        @mark = b+w
        @messenger.puts @mark
        if over?
          congrats = @guesses < 3 ? "Congratulations! " : ''
          guess_str = @guesses == 1 ? '1 guess' : "#{@guesses} guesses"
          @messenger.puts "#{congrats}You broke the code in #{guess_str}."
        end
      else
        raise "Bad #{guess.class.to_s}:#{guess.length} guess #{guess.to_s}"
      end
    end
  end
end
