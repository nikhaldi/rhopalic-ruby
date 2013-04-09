require 'rhopalic/analysis'

module Rhopalic

  def self.analyze_phrase(phrase)
    Analysis.new.analyze_phrase(phrase)
  end

  def self.letter_rhopalic?(phrase)
    analyzed = analyze_phrase(phrase)
    !analyzed.nil? && analyzed.letter_rhopalic?
  end

  def self.syllable_rhopalic?(phrase)
    analyzed = analyze_phrase(phrase)
    !analyzed.nil? && analyzed.syllable_rhopalic?
  end

  def self.rhopalic?(phrase)
    !analyze_phrase(phrase).nil?
  end

end
