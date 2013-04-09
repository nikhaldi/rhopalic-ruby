# encoding: UTF-8

require 'param_test'
require 'test/unit'

require 'rhopalic'

class Rhopalic::RhopalicTest < ActiveSupport::TestCase

  param_test "phrase %s is rhopalic", [
    "a",
    "a be",
    "the fine horse",
    "Words along rhopalic pentameters",
    # TODO these don't work. pull in dictionary?
    #"Add extra syllables gradually",
    #"While shadows, lengthening, attenuate",
    "Lines thicken approaching termination.",
    "it's fancy",
    "IT'S FANCY",
    "it's'bleak matter",
  ] do |phrase|
    assert Rhopalic.rhopalic?(phrase)
  end

  param_test "phrase %s is not rhopalic", [
    "a b",
    "be do",
    "a be ce",
    # TODO doesn't work because 'blonde' not recognized as one syllable
    #"going blonde monday"
    "bloom beta",
  ] do |phrase|
    assert !Rhopalic.rhopalic?(phrase)
  end

  param_test "phrase %s with accented characters is rhopalic",
  ["the café"] do |phrase|
    assert Rhopalic.rhopalic?(phrase)
  end

  def test_analyze_phrase_not_rhopalic
    assert_nil Rhopalic.analyze_phrase("three two")
  end

  def test_analyze_phrase
    phrase = Rhopalic.analyze_phrase("two four")
    assert_equal "two four", phrase.phrase
    assert_equal ["two", "four"], phrase.words
    assert_equal [0, 4], phrase.indices
    assert_equal [1, 1], phrase.syllable_counts
  end
end
