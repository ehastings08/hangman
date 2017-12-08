def display_word_with_guesses(word, guesses)
  # For each letter in the word, either display a "_ " or a letter depending on whether the letter is in guesses
  word_display = ""
  word.split("").each do |letter|
    guesses.include?(letter) ? word_display += "#{letter} " : word_display += "_ "
  end
  word_display

  # For letters in guesses but not word, display those after
end

puts "Expecting 't e _ t' "
puts display_word_with_guesses('test',['e','t'])
