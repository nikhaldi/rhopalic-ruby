module Rhopalic

  class Dictionary

    def initialize(input_source)
      @input_source = input_source
      make_dictionary
    end

    def syllable_count(word)
      @syllable_counts[word.upcase] || nil
    end

    private

    def make_dictionary
      @syllable_counts = {}
      @input_source.each do |line|
				next if line !~ /^[A-Z]/i
        line.chomp!
        (word, *phonemes) = line.split(/ +/)
        next if word[-1] == ")" # ignore alternative pronunciations
        @syllable_counts[word.upcase] = phonemes.grep(/^[AEIOU]/i).length
      end
    end
  end

end