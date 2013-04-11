require 'lingua'
require 'numbers_and_words'

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

      phrase.scan(/\b[[:alpha:]\d]+\b/) do
        match = Regexp.last_match
        word = match[0]
        index = match.begin(0)
        is_number = false

        # Bail out on words that contain numbers, unless we can pronounce the number
        # as a whole word.
        word.match(/\d+/) do |match|
          return nil if match[0].size != word.size
          is_number = true
        end

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

        # If the words is a series of digits, count syllables based on spelling the
        # number out, but ignore it if the number doesn't translate to a single word.
        syllable_counting_word = word
        if is_number
          number_as_words = word.to_i.to_words
          if number_as_words.match(/^\w+$/)
            syllable_counting_word = number_as_words
          else
            return nil
          end
        end

        if @dictionary
          syllable_count = @dictionary.syllable_count(syllable_counting_word)
          in_dictionary.push(true) unless syllable_count.nil?
        end
        if !syllable_count
          syllable_count = Lingua::EN::Syllable.syllables(syllable_counting_word)
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
