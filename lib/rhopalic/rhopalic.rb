require 'lingua'

require 'rhopalic/contractions'
require 'rhopalic/phrase'

module Rhopalic

  def self.analyze_phrase(phrase)
    last_letter_count = 0
    last_syllable_count = 0

    words = []
    indices = []
    syllable_counts = []

    # TODO this word definition is too simple. Needs to handle:
    # - apostrophes and hyphens in words
    # - non-ASCII characters
    # - numbers
    # - multiplied letters
    phrase.scan(/[[:alpha:]]+/) do
      match = Regexp.last_match
      word = match[0]
      index = match.begin(0)

      # Checking whether the previous and this word form a known contraction
      if !indices.empty? && (phrase[indices.last + words.last.length] == "'") &&
          (index == indices.last + words.last.length + 1)
        contraction = words.last + "'" + word
        if syllable_count = CONTRACTIONS[contraction.downcase]
          last_letter_count = contraction.size
          last_syllable_count = syllable_count
          words[-1] = contraction
          syllable_counts[-1] = syllable_count
          next
        end
      end

      letter_count = word.length
      syllable_count = Lingua::EN::Syllable.syllables(word)

      if syllable_count < last_syllable_count ||
         letter_count < last_letter_count ||
          (last_letter_count > 0 && last_letter_count != letter_count - 1 &&
          last_syllable_count > 0 && last_syllable_count != syllable_count - 1)
        return nil
      end

      last_letter_count = letter_count
      last_syllable_count = syllable_count

      words.push(word)
      indices.push(match.begin(0))
      syllable_counts.push(syllable_count)
    end

    return Phrase.new(phrase, words, indices, syllable_counts)
  end

  def self.rhopalic?(phrase)
    !analyze_phrase(phrase).nil?
  end

end
