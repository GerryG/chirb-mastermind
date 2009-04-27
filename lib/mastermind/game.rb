module Mastermind
  class Game
    def initialize(messenger, symbols='bcgrwy', size=4, allowdups=true)
      @messenger = messenger
      @size = size
      symbols='bcgrwy' unless symbols && symbols != ''
      @symbols=String(symbols)
      @allowdups=allowdups
    end
    
    def start(secret_code=nil)
      @messenger.puts "Welcome to Mastermind!"
      @messenger.puts "Enter guess:"
      unless secret_code
        secret_code = []
        @size.times do
          secret_code << @symbols[rand(@symbols.length)].chr
        end
      end
      if Array===secret_code && secret_code.length == @size
        raise "Game already in progress" if @mark && !over?
        @secret = secret_code
        @guesses = 0
        @hash = {}
        #maxchar = 'f' #'a'.succ(symbols)
        secret_code.each do |s|
          raise "Code element range #{s}" unless s.length == 1 &&
                                                 @symbols.include?(s)
          was = @hash[s] || 0
          raise "Duplicate code element #{s}" if !@allowdups && was 
          @hash[s] = was+1
        end
      else
         raise "Bad code #{secret_code.to_s}"
      end
    end

    def play(input=STDIN,pattern='')
      @input=input
      input.each_line do |line|
        begin
          guess(line.chomp.split(pattern))
          break if over?
        rescue RuntimeError=>e
          @messenger.puts e.message
        end
      end
    end

    def reset
      @mark=nil
    end

    def over?
      @mark && @mark == 'bbbb'
    end

    def secret
      @messenger.puts "Code: #{@secret}"
    end

    def guess(guess)
      if Array===guess && guess.length == 4
        guess.each do |g|
        end
        b=''; w=''
        hash = @hash.dup
        @guesses += 1
        @messenger.puts "Guess number #{@guesses}"
        wguess = []
        for i in 0..3
          g = guess[i]
          if hg = hash[g]
            if hg > 0 && g == @secret[i]
              hash[g] = hg-1
              b += 'b'
            else
              wguess << g
            end
          elsif !@symbols.include?(g)
            raise "Bad guess letter(#{g})"
          end
        end
        wguess.each do |g|
          if (hg = hash[g]) > 0
            hash[g] -= 1
            w += 'w'
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
