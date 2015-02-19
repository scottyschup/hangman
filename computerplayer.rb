class ComputerPlayer
  attr_reader :guesses

  def initialize
    @dictionary = File.readlines("dictionary.txt").map do |line|
      line.chomp
    end
    @guesses = Hash.new
  end

  def word_create
    @secret_word = @dictionary.sample.split("")
    @secret_word.count
  end

  def share_word_length(length)
    @filter_dictionary = @dictionary.keep_if { |word| word.length == length }
  end

  def filter_words
    letters_to_remove = @guesses.dup.keep_if { |k, v| !v }.keys
    letters_to_remove.each do |char|
      @filter_dictionary.keep_if { |word| !word.include?(char) }
    end
  end

  def freq_dist
    freq_dist = Hash.new
    ('a'..'z').each do |char|
      freq_dist[char] = 0
    end

    @filter_dictionary.each do |word|
      word.split("").each do |char|
        freq_dist[char] += 1
      end
    end

    freq_dist.keep_if { |k, v| !@guesses.keys.include?(k) }
  end

  def largest_hash_key(freq_dist)
    freq_dist.max_by { |k, v| v }
  end

  def guess_letter
    filter_words
    letter = largest_hash_key(freq_dist)[0]
    puts "I guess #{letter}."
    letter
  end

  def respond(letter)
    indexes = []
    if @secret_word.include?(letter)
      @secret_word.each_with_index do |char, index|
        indexes << index if char == letter
      end
    else
      puts "Word doesn't contain that letter."
    end
    indexes
  end

  def update_guesses(letter, word)
    @guesses[letter] = word.include?(letter)
  end

end
