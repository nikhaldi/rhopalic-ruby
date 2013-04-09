require 'param_test'
require 'test/unit'

require 'rhopalic/analysis'
require 'rhopalic/dictionary'

class Rhopalic::AnalysisTest < ActiveSupport::TestCase

  def setup
    @dict = Rhopalic::Dictionary.new([
      "ATTENUATE  AH0 T EH1 N Y UW0 EY2 T",
      "GRADUALLY  G R AE1 JH UW0 AH0 L IY0",
      "WHILE  W AY1 L",
    ])
    @analysis = Rhopalic::Analysis.new(@dict)
  end

  param_test "phrase %s has words in dictionary %s", [
    ["While shadows, lengthening, attenuate", [true, false, false, true]],
    ["Add extra syllables gradually", [false, false, false, true]],
  ] do |phrase, expected_in_dictionary|
    phrase = @analysis.analyze_phrase(phrase)
    assert_not_nil phrase
    assert phrase.syllable_rhopalic?
    assert_equal expected_in_dictionary, phrase.in_dictionary
  end
end
