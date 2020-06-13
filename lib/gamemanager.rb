# frozen_string_literal: true

# Manages the game
class GameManager
  attr_accessor :correct_positions

  def initialize(word)
    @correct_positions = []
    @guessed_letters = []

    word.strip.split('').each { @correct_positions.push(false) }
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

    valid = valid_input?(input)
    if valid
      correct = input_is_in_word?(word, input)
      if correct
        set_correct_position(word, input)
      else
        puts 'You\'re wrong!'
        @guessed_letters.push(input)
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
