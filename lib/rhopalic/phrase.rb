require 'lingua'

module Rhopalic

  class Phrase

    attr_reader :phrase, :is_letter_rhopalic, :is_syllable_rhopalic, :words, :indices, :syllable_counts
    alias_method :letter_rhopalic?, :is_letter_rhopalic
    alias_method :syllable_rhopalic?, :is_syllable_rhopalic

    def initialize(phrase, is_letter_rhopalic, is_syllable_rhopalic, words, indices, syllable_counts)
      @phrase = phrase
      @is_letter_rhopalic = is_letter_rhopalic
      @is_syllable_rhopalic = is_syllable_rhopalic
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
