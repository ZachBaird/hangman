# frozen_string_literal: true

require_relative 'wordbank'
require_relative 'gamemanager'
require_relative 'helpermethods'

wordbank = WordBank.new
wordbank.populate_words

Helpers.introduction

print "\nStart game: "
start = gets.chomp

system('clear') if start.capitalize == 'Y' || start.capitalize == 'Yes'

word = wordbank.pick_word_for_game
game = GameManager.new(word)

game.update_screen(word)

until game.correct_positions.all? { |position| position == true }
  special_result = game.read_and_validate_input(word)
  break if special_result == 'QUIT'

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
    puts '\n\nYour man has fallen to his doom :('
    puts 'Game over..'.red
    break
  end

  system('clear')
  game.update_screen(word)
end

puts "\n\nTerminating game..."
