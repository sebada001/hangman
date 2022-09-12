require './game'

class Saves
  require 'yaml'

  def initialize
    @saves = []
  end

  def load_game
    puts 'Want to load a game? y/n'
    return unless gets.chomp == 'y'

    game_state = YAML.safe_load(File.read('saves.yml'), permitted_classes: [Player, Game])
  end

  def save_game(game_to_save)
    File.open('saves.yml', 'w') { |file| file.write(game_to_save.to_yaml) }
  end
end

current_game = Game.new
saves = Saves.new
saves.save_game(current_game)
new_current_game = saves.load_game
new_current_game.play_game