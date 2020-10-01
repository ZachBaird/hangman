# frozen_string_literal: true

require 'json'

# Manages data serialization for saved games
class SaveGame
  # Saves the game to a JSON file.
  def commit_save(data)
    File.write('./saved-game.json', JSON.dump(data))
  end

  def resume_game
    file = File.read('./saved-game.json') if File.exist?('./saved-game.json')

    JSON.parse(file)
  end
end
