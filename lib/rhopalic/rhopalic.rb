require 'rhopalic/analysis'

module Rhopalic

  # Returns the analyzed phrase if it's rhopalic, nil otherwise.
  def self.analyze_phrase(phrase)
    Analysis.new.analyze_phrase(phrase)
  end

  # Returns whether the given phrase is letter-rhopalic in English (each
  # word has one letter more than the preceding one).
  def self.letter_rhopalic?(phrase)
    analyzed = analyze_phrase(phrase)
    !analyzed.nil? && analyzed.letter_rhopalic?
  end

  # Returns whether the given phrase is syllable-rhopalic in English (each
  # word has one syllable more than the preceding one).
  def self.syllable_rhopalic?(phrase)
    analyzed = analyze_phrase(phrase)
    !analyzed.nil? && analyzed.syllable_rhopalic?
  end

  # Returns whether the given phrase is letter-rhopalic or syllable-rhopalic.
  def self.rhopalic?(phrase)
    !analyze_phrase(phrase).nil?
  end

end
