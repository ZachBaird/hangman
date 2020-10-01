# frozen_string_literal: true

require_relative 'savegame'

# Manages the game
class GameManager
  attr_accessor :correct_positions

  def initialize(word, positions = nil, letters = nil)
    if positions.nil? && letters.nil?
      @correct_positions = [] if positions.nil?
      @guessed_letters = [] if letters.nil?

      word.strip.split('').each { @correct_positions.push(false) }
    else
      @correct_positions = positions.split('').map { |pos| pos == '1' }
      @guessed_letters = letters.split('')
    end
  end

  # Saves the game's current state
  def save_game(word)
    data_to_serialize = {}

    # Add current word to hash
    data_to_serialize['word'] = word

    # Add the guessed_letters to hash as a string
    data_to_serialize['guessed_letters'] = @guessed_letters.join

    # Add the correct positions into an array as a '1' or '0'
    correct_guesses = @correct_positions.map do |position|
      if position
        '1'
      else
        '0'
      end
    end

    # Add the compiled correct data to the hash as a string
    data_to_serialize['position_data'] = correct_guesses.join

    # Initialize a SaveGame class and commit the data to a file
    save = SaveGame.new
    save.commit_save(data_to_serialize)
  end

  # Updates the screen with the word
  def update_screen(word, show_word = false)
    puts 'Here is the word: '

    split_word = word.strip.split('').map(&:strip)

    puts word if show_word

    split_word.each_with_index do |letter, index|
      next if letter.nil?

      if (@correct_positions[word.index(letter)] && index != word.length) || show_word
        print " #{letter} "
      else
        print ' _ '
      end
    end

    puts "\n\nGuessed letters:"
    @guessed_letters.each { |letter| print "#{letter} " }
  end

  # Prompts the user for a letter, reads in the letter and
  #  runs testing on it for valid input and if it was
  #  on the money
  def read_and_validate_input(word)
    return 'GAMEOVER' if @guessed_letters.length == 6

    print "\n\n\t Letter selection: "
    input = gets.chomp
    input.downcase!

    return 'QUIT' if input == 'qg'
    return 'WORD' if input == 'gw'
    return 'SAVE' if input == 'sg'

    valid = valid_input?(input)
    if valid
      correct = input_is_in_word?(word, input)
      if correct
        set_correct_position(word, input)
      else
        puts 'You\'re wrong!'
        @guessed_letters.push(input) unless @guessed_letters.include?(input)
      end
    else
      puts 'Invalid input'
    end
  end

  # Determines if the input was valid
  def valid_input?(input)
    return false unless input.length == 1 && input.match?(/[a-z]/)

    true
  end

  # Determines if the user's input is in the word
  def input_is_in_word?(word, input)
    word.downcase.include?(input)
  end

  # Sets a position as 'correct'
  def set_correct_position(word, input)
    word.strip.split('').each_with_index do |letter, index|
      @correct_positions[index] = true if letter.downcase == input
    end
  end

  # Guess the word
  def guess_word(word)
    print 'Your guess: '
    input = gets.chomp
    input.strip.downcase == word.strip.downcase
  end
end
