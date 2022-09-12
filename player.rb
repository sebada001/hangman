class Player
  attr_reader :name, :score

  def initialize(name = nil, score = nil)
    if name.nil?
      p "Player what's your name?"
      names = gets.chomp
      @name = names
    else
      @name = name
    end
    @score = score.nil? ? 15 : score
  end

  def lower_score
    @score -= 1
  end

  def print_score
    p "#{@name} you have #{@score} tries left to guess the secret word, give it your best shot!"
  end
end