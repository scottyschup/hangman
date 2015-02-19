require 'byebug'
load 'computerplayer.rb'
load 'humanplayer.rb'

class Hangman
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @word = Array.new(@player1.word_create) { '_' }
    @player2.share_word_length(@word.count)
  end


  def play
    while @word.include?('_')
      letter = @player2.guess_letter
      indexes = @player1.respond(letter)
      add_letters(letter, indexes)
      @player2.update_guesses(letter, @word)
      display
    end
    end_game
    [@word.join(''), @player2.guesses.keys]
  end

  private
  def display
    puts "Secret word: #{@word.join(" ")}"
    position = ''
    (@word.length).times { |i| position <<  "#{i + 1} " }
    puts "(Position)   #{position}"
    puts "Guesses so far: #{@player2.guesses.keys.join(" ")}\n\n"
  end

  def add_letters(letter, indexes)
    indexes.each do |index|
      @word[index] = letter
    end
  end

  def end_game
    puts "Congratulations!
You guessed the #{@word.count}-letter word #{@word.join("").upcase} in #{@player2.guesses.count} tries!"
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Is Player One (the word maker) a human (y/n)? "
  if gets.chomp == "y"
    creator = HumanPlayer.new
  else
    creator = ComputerPlayer.new
  end

  print "Is Player Two (the guesser) a human (y/n)? "
  if gets.chomp == "y"
    guesser = HumanPlayer.new
  else
    guesser = ComputerPlayer.new
  end

  Hangman.new(creator, guesser).play
end
