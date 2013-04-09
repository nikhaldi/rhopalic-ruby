require 'test/unit'

require 'rhopalic/dictionary'

class Rhopalic::DictionaryTest < Test::Unit::TestCase

  def test_constructor
    source = [
      ";;; comment",
      "\"QUOTE  K W OW1 T",
      "ABATEMENT  AH0 B EY1 T M AH0 N T",
      "CAFETERIA  K AE2 F AH0 T IH1 R IY0 AH0",
      "CAFETERIA(1)  K AE2 F AH0 T IH1 R IY0 AH0",
    ]
    dict = Rhopalic::Dictionary.new(source)
    assert_nil dict.syllable_count("foo")
    assert_equal 3, dict.syllable_count("abatement")
    assert_equal 3, dict.syllable_count("Abatement")
    assert_equal 5, dict.syllable_count("cafeteria")
    assert_nil dict.syllable_count(";;;")
    assert_nil dict.syllable_count("\"quote")
    assert_nil dict.syllable_count("cafeteria(1)")
  end
end
