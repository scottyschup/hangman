class HumanPlayer
  attr_reader :guesses

  def initialize
    @guesses = Hash.new
  end

  def word_create
    puts "How long is your word?"
    gets.chomp.to_i
  end

  def share_word_length(length)
    puts "The word is #{length} characters long."
  end

  def guess_letter
    puts "Guess a letter: "
    gets.chomp
  end

  def respond(letter)
    puts "Is there a letter '#{letter}'? [y/n]"
    if gets.chomp == "y"
      puts "At what position(s)? (If more than one, separate with a space.)"
      indexes = gets.chomp.split(" ")
      indexes.map(&:to_i).map { |i| i - 1 }
    else
      return []
    end
  end

  def update_guesses(letter, word)
    @guesses[letter] = word.include?(letter)
  end
end
