class Game
  def initialize
    @dict = load_dict
    @word = @dict.sample
    @turns = 0
    @guesses = []

    puts "Starting a new game!"
    puts "The dictionary has chosen a word."
    puts "#{@word}"
  end

  # Ingest a dictionary of words separated by lines and add the valid ones (based on length) to an array
  def load_dict
    words = []
    File.open("dict.txt").each do |line| # Hard code for now
      if line.length.between?(5, 12)
        words << line
      end
    end
    words
  end

  def get_display_word(word, guesses)
    # For each letter in the word, either display a "_ " or a letter depending on whether the letter is in guesses
    word_display = ""
    word.split("").each do |letter|
      guesses.include?(letter) ? word_display += "#{letter} " : word_display += "_ "
    end
    word_display
  end

  def get_display_incorrect_guesses(word, guesses)
    # For letters in guesses but not word, display those after as a string separated with spaces
    incorrect_guesses = guesses - word.split("")
    display_incorrect_guesses = incorrect_guesses.join(" ")
  end

  def display_word_and_incorrect_guesses(word, guesses)
    puts "Guessed word so far: #{get_display_word(word, guesses)}"
    puts "Your incorrect guesses so far: #{get_display_incorrect_guesses(word, guesses)}"
  end

  def display_turn_count(word, turns)
    puts "You have taken #{turns} turns. You have #{20 - turns} guesses left to make."
  end

end

new_game = Game.new