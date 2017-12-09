require 'json'

class Game

  def initialize
    puts "Welcome to Hangman! Would you like to start a new game or load an old game? For a new game, type 'n'. For an old game, type 'o'."
    answer = nil
    until answer == 'n' || answer == 'o'
      puts "Please select a new game (n) or an old game (o)."
      answer = gets.chomp
    end
    answer == 'n' ? start_new_game : continue_saved_game
  end

  def start_new_game
    @dict = load_dict
    @word = @dict.sample
    @turns = 0
    @guesses = []
    @total_guesses_allowed = 15

    puts "Starting a new game!"
    puts "The dictionary has chosen a word."
    # puts "#{@word}" # For debugging only

    run_game
  end

  # WIP
  def continue_saved_game
    #{ }Continue saved game! Go to load game method. Then run the game.

    exists = nil
    until exists
      puts "Please enter the name of an old game."
      filename = gets.chomp
      exists = File.exist?("#{filename}.json")
    end
    load_game("#{filename}.json")
  end

  def run_game
    until game_over?(@word)
      start_turn
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

  def turn_or_save_choice
    puts "\nWould you like to save the game or take your turn? To save, type 's'. To take a turn, type 't'."
    choice = gets.chomp
    until choice == 's' || choice == 't'
      puts "Please select save (s) or take turn (t)."
      choice = gets.chomp
    end

    choice
  end

  def start_turn
    # Provide player option to save game
    choice = turn_or_save_choice
    if choice == 't'
      take_turn
    else
      save_game
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
    # Increment turn
    @turns += 1
  end

  # Define a to_json method to serialize the class to a JSON string
  def to_json(*a)
    {
      "word" => @word,
      "turns" => @turns,
      "guesses" => @guesses,
      "total_guesses_allowed" => @total_guesses_allowed
    }.to_json(*a)
  end

  def json_create(obj)
    @word = obj["word"]
    @turns = obj["turns"]
    @guesses = obj["guesses"]
    @total_guesses_allowed = obj["total_guesses_allowed"]
    run_game
  end

  def save_game
    json_string = self.to_json

    puts "Please label this game so you can access it later."
    name = gets.chomp
    File.open("#{name}.json", "w") do |f|
      f.write(json_string)
    end
    puts "Save complete! Exiting game."
    exit
  end

  def load_game(filename)
    json_string = File.read(filename)
    json_create(JSON.parse(json_string))
  end

  def game_over?(word)
    (word.split("").uniq - @guesses == [] || @guesses.length == @total_guesses_allowed) ? true : false
  end

  def won_game?(word)
    word.split("").uniq - @guesses == [] ? true : false
  end

end

new_game = Game.new