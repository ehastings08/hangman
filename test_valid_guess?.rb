GUESSES = ['a','b','c']

def valid_guess?(letter_guess)
  # Validate that the guess is a single alpha character before input
  (letter_guess.length == 1 && !letter_guess.match(/[^A-Za-z]/) && !GUESSES.include?(letter_guess)) ? true : false
end

puts "Should return true: #{valid_guess?('d')}"
puts "Should return false: #{valid_guess?('a')}"
puts "Should return false: #{valid_guess?('-')}"
puts "Should return false: #{valid_guess?('')}"