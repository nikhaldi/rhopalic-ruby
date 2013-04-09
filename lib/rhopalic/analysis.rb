require 'lingua'

require 'rhopalic/contractions'
require 'rhopalic/phrase'

module Rhopalic
  class Analysis

    def analyze_phrase(phrase)
      last_letter_count = 0
      last_syllable_count = 0

      words = []
      indices = []
      syllable_counts = []
      is_letter_rhopalic = true
      is_syllable_rhopalic = true

      # TODO this word definition is too simple. Needs to handle:
      # - numbers
      # - multiplied letters
      # - possessives
      phrase.scan(/[[:alpha:]]+/) do
        match = Regexp.last_match
        word = match[0]
        index = match.begin(0)

        # Checking whether the previous and this word form a known contraction
        if !indices.empty? && (phrase[indices.last + words.last.length] == "'") &&
            (index == indices.last + words.last.length + 1)
          contraction = words.last + "'" + word
          if syllable_count = CONTRACTIONS[contraction.downcase]
            # TODO makes this non-letter rhopalic for sure
            last_letter_count = contraction.size
            last_syllable_count = syllable_count
            words[-1] = contraction
            syllable_counts[-1] = syllable_count
            next
          end
        end

        letter_count = word.length
        syllable_count = Lingua::EN::Syllable.syllables(word)

        if last_letter_count > 0 && last_letter_count + 1 != letter_count
          is_letter_rhopalic = false
        end
        if last_syllable_count > 0 && last_syllable_count + 1 != syllable_count
          is_syllable_rhopalic = false
        end
        return nil unless is_letter_rhopalic || is_syllable_rhopalic

        last_letter_count = letter_count
        last_syllable_count = syllable_count

        words.push(word)
        indices.push(match.begin(0))
        syllable_counts.push(syllable_count)
      end

      return Phrase.new(phrase, is_letter_rhopalic, is_syllable_rhopalic, words, indices, syllable_counts)
    end

  end
end
