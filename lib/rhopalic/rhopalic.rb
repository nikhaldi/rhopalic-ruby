require 'rhopalic/analysis'

module Rhopalic

  def self.analyze_phrase(phrase)
    Analysis.new.analyze_phrase(phrase)
  end

  def self.rhopalic?(phrase)
    !analyze_phrase(phrase).nil?
  end

end
