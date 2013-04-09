require 'lingua'

module Rhopalic

  # A rhopalic phrase with all the artifacts from the rhopalic analysis.
  class Phrase

    attr_reader :phrase, :is_letter_rhopalic, :is_syllable_rhopalic, :words, :indices,
        :syllable_counts, :in_dictionary
    alias_method :letter_rhopalic?, :is_letter_rhopalic
    alias_method :syllable_rhopalic?, :is_syllable_rhopalic

    def initialize(phrase, is_letter_rhopalic, is_syllable_rhopalic, words, indices,
        syllable_counts, in_dictionary)
      @phrase = phrase
      @is_letter_rhopalic = is_letter_rhopalic
      @is_syllable_rhopalic = is_syllable_rhopalic
      @words = words
      @indices = indices
      @syllable_counts = syllable_counts
      @in_dictionary = in_dictionary
    end

    def each_word
      words.zip(indices, syllable_counts, in_dictionary) do |args|
        yield args[0], args[1], args[2], args[3]
      end
    end
  end

end
