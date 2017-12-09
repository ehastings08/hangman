class Game
  def initialize
    @dict = load_dict
    @word = @dict.sample
    @turns = 0
    @guesses = []
    @total_guesses_allowed = 15

    puts "Starting a new game!"
    puts "The dictionary has chosen a word."
    puts "#{@word}"
    # WIP - start with one turn, then add loop
    until game_over?(@word)
      take_turn
    end

    puts won_game?(@word) ? "You won!" : "Sorry, try again"
  end

  # Ingest a dictionary of words separated by lines and add the valid ones (based on length) to an array
  def load_dict
    words = []
    File.open("dict.txt").each do |line| # Hard code for now
      if line.length.between?(5, 12)
        words << line.rstrip.downcase
      end
    end
    words
  end

  def get_display_word(word)
    # For each letter in the word, either display a "_ " or a letter depending on whether the letter is in guesses
    # This is acting up WIP
    word_display = ""
    word.split("").each do |letter|
      @guesses.include?(letter) ? word_display += "#{letter} " : word_display += "_ "
    end
    word_display
  end

  def get_display_incorrect_guesses(word)
    # For letters in guesses but not word, display those after as a string separated with spaces
    incorrect_guesses = @guesses - word.split("")
    display_incorrect_guesses = incorrect_guesses.join(" ")
  end

  def display_word_and_incorrect_guesses(word)
    puts "Guessed word so far: #{get_display_word(word)}"
    puts "Your incorrect guesses so far: #{get_display_incorrect_guesses(word)}"
  end

  def display_turn_count
    puts "You have taken #{@turns} turns. You have #{@total_guesses_allowed - @turns} guesses left to make."
  end

  # Validate that the guess is a single alpha character that has not yet been guessed
  def valid_guess?(letter_guess)
    (letter_guess.length == 1 && !letter_guess.match(/[^A-Za-z]/) && !@guesses.include?(letter_guess)) ? true : false
  end

  def make_guess(word, letter_guess)
    # Refactor q: What about if person has already made this guess?
    @guesses << letter_guess.downcase

    if word.split("").include?(letter_guess)
      puts "The letter #{letter_guess} is correct!"
    else
      puts "The letter #{letter_guess} is incorrect."
    end
  end

  def take_turn
    # Display turn count
    display_turn_count
    # Display the current word and incorrect guesses
    display_word_and_incorrect_guesses(@word)
    # Prompt user for input
    puts "Please make a guess"
    # Validate guess
    valid = nil
    until valid
      puts "Please enter a single alphabetical character as your guess. Do not repeat guesses."
      letter_guess = gets.chomp
      valid = valid_guess?(letter_guess)
    end
    # Make the guess - add letter guess to guesses and confirm
    make_guess(@word, letter_guess)
    # Display the word now
    display_word_and_incorrect_guesses(@word)
    # End turn?
  end

  def game_over?(word)
    (word.split("").uniq - @guesses == [] || @guesses.length == @total_guesses_allowed) ? true : false
  end

  def won_game?(word)
    word.split("").uniq - @guesses == [] ? true : false
  end

end

new_game = Game.new