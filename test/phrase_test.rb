require 'test/unit'

require 'rhopalic/phrase'

class Rhopalic::PhraseTest < Test::Unit::TestCase

  def test_constructor_inits_accessors
    phrase = Rhopalic::Phrase.new("one", ["one"], [0], [1])
    assert_equal "one", phrase.phrase
    assert_equal ["one"], phrase.words
    assert_equal [0], phrase.indices
    assert_equal [1], phrase.syllable_counts
  end

  def test_each_word
    phrase = Rhopalic::Phrase.new("one four", ["one", "four"], [0, 4], [1, 1])
    results = []
    phrase.each_word do |word, index, syllable_count|
      results.push([word, index, syllable_count])
    end
    assert_equal [["one", 0, 1], ["four", 4, 1]], results
  end
end
