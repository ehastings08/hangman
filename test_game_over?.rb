word = 'hangman'

guesses1 = ['h','a','n','g','m','n']
guesses2 = ['h']
guesses3 = %w(a b c d e f g)

def game_over?(word, guesses)
  (word.split("").uniq - guesses == [] || guesses.length == @total_guesses_allowed) ? true : false
end

puts "Expecting true: #{game_over?(word, guesses1)}"
puts "Expecting false: #{game_over?(word, guesses2)}"
puts "Expecting false: #{game_over?(word, guesses3)}"
