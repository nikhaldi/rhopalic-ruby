require 'lingua'

class Rhopalic

  def self.is_rhopalic(phrase)
    # TODO handle apostrophes
    last_letter_count = 0
    last_syllable_count = 0
    phrase.scan(/\w+/) do |match|
      letter_count = match.length
      syllable_count = Lingua::EN::Syllable.syllables(match)

      if last_letter_count > 0 && last_letter_count != letter_count - 1 &&
          last_syllable_count > 0 && last_syllable_count != syllable_count - 1
        return false
      end

      last_letter_count = letter_count
      last_syllable_count = syllable_count
    end

    return true
  end

end
