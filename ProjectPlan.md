# Game class

## Initialize - Complete

- When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word.

## Display running count for turns - Complete
- You don’t need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses she has before the game ends.

## Display current word - Complete
- You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) ...

## Display incorrect guesses - Complete
- ...and which incorrect letters have already been chosen.

## Update display method - Complete
- Takes a guess letter and reflects whether the letter was correct or incorrect.

## Run turns - Complete
- Every turn, allow the player to make a guess of a letter. It should be case insensitive.
- Update the display to reflect whether the letter was correct or incorrect.

## Game over? - Complete
- If out of guesses, the player should lose.
- If they guess the word, the player should win

## Make guesses case insensitive



# Serialization

## Save option
- Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects… you can serialize your game class too!

## Open option
- When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!



## References

### JSON

- https://www.skorks.com/2010/04/serializing-and-deserializing-objects-with-ruby/

Serialize:

puts "JSON:"
time = benchmark_serialize("/home/alan/tmp/json.dat") do |file, object|
  file.puts object.to_json
end
puts "Time: #{time} sec"

Deserialize:

array2 = []
puts "JSON:"
time = benchmark_deserialize("/home/alan/tmp/json.dat", array2, "\n") do |object|
  JSON.parse(object)
end
puts "Array size: #{array2.length}"
puts "Time: #{time} sec"

### PStore?