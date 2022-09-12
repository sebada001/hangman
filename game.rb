require './player'

class Game
  attr_reader :secret_word

  def initialize (secret_word = nil, current_guess = '', player = nil)
    words_array = []
    words = File.readlines('google-10000-english-no-swears.txt')
    words.each { |line| words_array.push(line[0..-2]) if line.length >= 5 && line.length <= 12 }
    @alphabet = ('a'..'z').to_a
    @secret_word = secret_word.nil? ? words_array.sample(1)[0] : secret_word
    @secret_length = @secret_word.length
    @current_guess = current_guess
    if @current_guess == ''
      @secret_length.times { @current_guess << '_' }
    end
    @player = player.nil? ? Player.new : player
    @game_won = false
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
  end

  def response_printer(resp)
    if resp[0]
      p "#{resp[1]} was right! Your current guess is: "
    else
      p "#{resp[1]} was wrong! Your current guess is: "
    end
    display_current_guess
    resp
  end

  def check_win
    @current_guess.split('') == @secret_word.split('')
  end

  def play_game
    display_current_guess
    game_loop
    message =
      if @game_won
        "You won! The secret word was #{@secret_word}"
      else
        "You lost! The secret word was #{@secret_word}"
      end
    p message
  end

  def game_loop
    while @game_won == false && @player.score.positive?
      make_guess
      @player.lower_score
      @game_won = check_win
      break if @game_won

      @player.print_score
    end
  end

  def make_guess
    guess = gets.chomp[0]
    guess = guess.nil? ? 'x' : guess.downcase
    evaluate_guess(guess)
  end
  p 'Welcome to hangman! You have 15 chances to guess a secret word!'
end
