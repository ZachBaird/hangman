# Oreo Hangman

Enjoy a game of hangman built in Ruby.

## Getting Started

All you need to run this is Ruby. I wrote this in Ruby 2.7.0. Once Ruby is on your machine, run:

`gem install colorize`

## The Files

There are five files in the lib folder:

* gamemanager.rb - The workhorse for the game.
* helpermethods.rb - Contains a module with some static helper methods.
* main.rb - The main execution of the program.
* savegame.rb - Contains a SaveGame class that handles the direct reading and writing of files for saved games.
* wordbank.rb - Class that creates a list of words from the words.txt file.

## Playing

1. Clone the repo.
2. `cd` into `hangman`.
3. Run `ruby lib/main.rb`.
