module Rhopalic

  # A dictionary that maps words to of syllables. Can be passed into
  # Rhopalic::Analysis to improve accuracy of syllable detection. Input
  # is a pronunciation file in the format of the CMU pronunciation
  # dictionary. See http://www.speech.cs.cmu.edu/cgi-bin/cmudict for
  # details. The latest dictionary file from CMU should work out of the
  # box.
  class Dictionary

    # Initializes a dictionary from an enumberable source of dictionary
    # entries, e.g., an open dictionary file.
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