require 'test/unit'

require 'rhopalic/phrase'

class Rhopalic::PhraseTest < Test::Unit::TestCase

  def test_constructor_inits_accessors
    phrase = Rhopalic::Phrase.new("one", true, true, ["one"], [0], [1], [false])
    assert_equal "one", phrase.phrase
    assert phrase.letter_rhopalic?
    assert phrase.syllable_rhopalic?
    assert_equal ["one"], phrase.words
    assert_equal [0], phrase.indices
    assert_equal [1], phrase.syllable_counts
    assert_equal [false], phrase.in_dictionary
  end

  def test_each_word
    phrase = Rhopalic::Phrase.new("one four", true, false, ["one", "four"], [0, 4], [1, 1],
        [false, false])
    results = []
    phrase.each_word do |word, index, syllable_count, in_dictionary|
      results.push([word, index, syllable_count, in_dictionary])
    end
    assert_equal [["one", 0, 1, false], ["four", 4, 1, false]], results
  end
end
