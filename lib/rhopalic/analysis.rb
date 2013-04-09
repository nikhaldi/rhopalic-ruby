require 'lingua'

require 'rhopalic/contractions'
require 'rhopalic/phrase'

module Rhopalic
  class Analysis

    def initialize(dictionary=nil)
      @dictionary = dictionary
    end

    def analyze_phrase(phrase)
      words = []
      indices = []
      syllable_counts = []
      in_dictionary = []
      is_letter_rhopalic = true
      is_syllable_rhopalic = true

      # TODO this word definition is too simple. Needs to handle:
      # - numbers
      phrase.scan(/[[:alpha:]]+/) do
        match = Regexp.last_match
        word = match[0]
        index = match.begin(0)

        # Checking whether the previous and this word form a known contraction
        # or possessive.
        if !indices.empty? && (phrase[indices.last + words.last.length] == "'") &&
            (index == indices.last + words.last.length + 1)
          contraction = words.last + "'" + word
          if (syllable_count = CONTRACTIONS[contraction.downcase]) || word.downcase == "s"
            words[-1] = contraction
            if syllable_count
              syllable_counts[-1] = syllable_count
              in_dictionary[-1] = true
            end

            is_letter_rhopalic = false unless word_sequence_rhopalic?(words)
            is_syllable_rhopalic = false unless syllable_sequence_rhopalic?(syllable_counts)
            return nil unless is_letter_rhopalic || is_syllable_rhopalic
            next
          end
        end

        if @dictionary
          syllable_count = @dictionary.syllable_count(word)
          in_dictionary.push(true) unless syllable_count.nil?
        end
        if !syllable_count
          syllable_count = Lingua::EN::Syllable.syllables(word)
          in_dictionary.push(false)
        end

        words.push(word)
        indices.push(match.begin(0))
        syllable_counts.push(syllable_count)

        is_letter_rhopalic = false unless word_sequence_rhopalic?(words)
        is_syllable_rhopalic = false unless syllable_sequence_rhopalic?(syllable_counts)
        return nil unless is_letter_rhopalic || is_syllable_rhopalic
      end

      return Phrase.new(phrase, is_letter_rhopalic, is_syllable_rhopalic, words, indices,
          syllable_counts, in_dictionary)
    end

    private

    def word_sequence_rhopalic?(words)
      words.size < 2 || words[-2].length + 1 == words[-1].length
    end

    def syllable_sequence_rhopalic?(syllable_counts)
      syllable_counts.size < 2 || syllable_counts[-2] + 1 == syllable_counts[-1]
    end
  end
end
