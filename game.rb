class Game
  attr_reader :secret_word

  def initialize
    words_array = []
    words = File.readlines('google-10000-english-no-swears.txt')
    words.each { |line| words_array.push(line[0..-2]) if line.length >= 5 && line.length <= 12 }
    @alphabet = ('a'..'z').to_a
    @secret_word = words_array.sample(1)[0]
    @secret_length = @secret_word.length
    @current_guess = ''
    @secret_length.times { @current_guess << '_' }
  end

  def display_current_guess
    guess_display = ''
    @current_guess.each_char do |char|
      guess_display << char.to_s << ' '
    end
    p guess_display[0..-2]
  end

  def evaluate_guess(char)
    return false unless @alphabet.include?(char)

    @alphabet.delete(char)
    guess_right = false
    @secret_word.each_char.with_index do |c, ind|
      if @secret_word[ind] == char
        @current_guess[ind] = c
        guess_right = true
      end
    end
    response_printer([guess_right, char])
    [guess_right, char]
  end

  def response_printer(resp)
    if resp[0]
      p "#{resp[1]} was right! Your current guess is: "
    else
      p "#{resp[1]} was wrong! Your current guess is: "
    end
    display_current_guess
  end

  def check_win
    @current_guess.split('') == @secret_word.split('')
  end
end
