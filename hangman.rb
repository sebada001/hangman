require './player'

class Saves
  require "yaml"

  def initialize
    @saves = []
  end

  def load_game
    puts 'Want to load a game? y/n'
    return unless gets.chomp == 'y'

    game_array = Player.new(YAML.safe_load(File.read('saves.yml')))
    p game_array
  end

  def save_game(game_to_save)
    File.open('saves.yml', 'w') { |file| file.write(game_to_save.to_yaml) }
  end
end

player_me = Player.new
saves = Saves.new
saves.save_game(player_me)
saves.load_game
