require 'lingua'

module Rhopalic

  class Phrase

    attr_reader :phrase, :words, :indices, :syllable_counts

    def initialize(phrase, words, indices, syllable_counts)
      @phrase = phrase
      @words = words
      @indices = indices
      @syllable_counts = syllable_counts
    end

    def each_word
      words.zip(indices, syllable_counts) do |args|
        yield args[0], args[1], args[2]
      end
    end
  end

end
