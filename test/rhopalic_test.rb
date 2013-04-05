require 'param_test'
require 'test/unit'

require 'rhopalic'

class RhopalicTest < ActiveSupport::TestCase

  param_test "phrase %s is rhopalic",
  ["a be"] do |phrase|
    assert Rhopalic.is_rhopalic(phrase)
  end
end
