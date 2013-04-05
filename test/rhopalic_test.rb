# encoding: UTF-8

require 'param_test'
require 'test/unit'

require 'rhopalic'

class RhopalicTest < ActiveSupport::TestCase

  param_test "phrase %s is rhopalic", [
    "a",
    "a be",
    "the fine horse",
    "Words along rhopalic pentameters",
    # TODO these don't work. pull in dictionary?
    #"Add extra syllables gradually",
    #"While shadows, lengthening, attenuate"
    "Lines thicken approaching termination.",
  ] do |phrase|
    assert Rhopalic.is_rhopalic(phrase)
  end

  param_test "phrase %s is not rhopalic", [
    "a b",
    "be do",
    "a be ce",
  ] do |phrase|
    assert !Rhopalic.is_rhopalic(phrase)
  end

  # TODO doesn't work because of word definition
  # param_test "phrase %s with accented characters is rhopalic",
  # ["the café"] do |phrase|
  #   assert Rhopalic.is_rhopalic(phrase)
  # end
end
