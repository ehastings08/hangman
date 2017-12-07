class Game
  def initialize
    puts "Starting a new game!"
    @dict = load_dict
    @word = @dict.sample
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

  def display_word
  end

  def display_turn_count(turn)
  end

end

new_game = Game.new