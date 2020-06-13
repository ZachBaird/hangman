# frozen_string_literal: true

# Class containing word bank data and API to manage it
class WordBank
  def initialize
    @words_bank = []
  end

  # Populates the words_bank state
  def populate_words
    # Pull file content
    file_content = File.open 'words.txt' if File.exist? 'words.txt'

    # Pull out the words line by line and then push them into our word_bank
    #  for any word that's longer than 5 letters
    return if file_content.nil?

    words = file_content.readlines
    words.each { |word| @words_bank.push(word) if word.length > 5 }
  end

  def pick_word_for_game
    @words_bank[rand(0..@words_bank.length)]
  end

  # Prints each word line by line or nothing if the word bank is empty
  def print_words
    return if @words_bank.empty?

    @words_bank.each { |word| puts word }
  end
end
