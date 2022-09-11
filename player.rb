require './game'

class Player
  def initialize
    puts "Welcome to Hangman, what's your name?"
    @name = gets.chomp
    @score = 15
    @game_won = false
    @game = Game.new
    puts "#{@name} you have #{@score} tries left to guess the secret word, give it your best shot!"
    @game.display_current_guess
  end

  def play_game
    while @game_won == false && @score.positive?
      make_guess
      @score -= 1
      @game_won = @game.check_win
      break if @game_won

      print_score
    end
    message =
      if @game_won
        "You won! The secret word was #{@game.secret_word}"
      else
        "You lost! The secret word was #{@game.secret_word}"
      end
    p message
  end

  def make_guess
    guess = gets.chomp[0].downcase
    @game.evaluate_guess(guess)
  end

  def print_score
    p "#{@name} you have #{@score} tries left to guess the secret word, give it your best shot!"
  end
end