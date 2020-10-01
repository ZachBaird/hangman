# frozen_string_literal: true

require_relative 'wordbank'
require_relative 'gamemanager'
require_relative 'helpermethods'
require_relative 'savegame'

# Runs one game loop
def game_loop(game, word)
  game.update_screen(word)

  until game.correct_positions.all? { |position| position == true }
    special_result = game.read_and_validate_input(word)
    break if special_result == 'QUIT'

    if special_result == 'SAVE'
      game.save_game(word)
      break
    end

    if special_result == 'WORD'
      correct = game.guess_word(word)
      if correct
        puts "\n\nCongratulations! You won!"
        game.update_screen(word, true)
        break
      else
        puts "\nYou were wrong :("
        game.update_screen(word)
        next
      end
    end

    if special_result == 'GAMEOVER'
      puts "\n\nYour man has fallen to his doom :("
      puts "The Word was #{word}\n"
      puts 'Game over..'.red
      break
    end

    system('clear')
    game.update_screen(word)
  end
end

wordbank = WordBank.new
wordbank.populate_words

Helpers.introduction

if File.exist?('./saved-game.json')
  puts "\nIt appears there is a game saved. Would you like to load the saved game or start fresh?"
  print "\t (Y / N): "
  response = gets.chomp

  if response.capitalize == 'Y' || response.capitalize == 'Yes'
    system('clear')
    save_reader = SaveGame.new

    game_data = save_reader.resume_game

    game = GameManager.new(game_data['word'],
                           game_data['position_data'],
                           game_data['guessed_letters'])

    # Delete save game
    File.delete('./saved-game.json') if File.exist?('./saved-game.json')

    game_loop(game, game_data['word'])
  else
    # Delete save game
    File.delete('./saved-game.json') if File.exist?('./saved-game.json')

    system('clear')

    word = wordbank.pick_word_for_game
    game = GameManager.new(word)

    game_loop(game, word)
  end
else
  print "\nStart game: "
  start = gets.chomp

  system('clear') if start.capitalize == 'Y' || start.capitalize == 'Yes'

  word = wordbank.pick_word_for_game
  game = GameManager.new(word)

  game_loop(game, word)
end

puts "\n\nTerminating game..."
