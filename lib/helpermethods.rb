# frozen_string_literal: true

require 'colorize'

# Contains helper methods to keep main.rb clean
module Helpers
  # Introduces player to game
  def self.introduction
    puts "\nStarting Game!!!\n".blue
    puts "WELCOME to Hangman! :D\n"
    puts 'If you have never played before, here is the how to:'
    puts "\t - A number of empty spaces will be displayed"
    puts "\t - Each space is for a letter in the word"
    puts "\t - You get to guess a letter every round"
    puts "\t - If you're right, the letter is put into the word"
    puts "\t - If you're, our man gets a little closer to falling to his doom\n"
    puts "\t - If you want to guess the whole word, enter 'gw' to Guess Word".green
    puts "\t - At any time in the game enter 'qg' to Quit Game".red
    puts "\t - If you would like to save the game rather than quit, enter 'sg'".green
  end
end
