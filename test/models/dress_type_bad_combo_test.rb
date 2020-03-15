require 'test_helper'

class DressTypeBadComboTest < ActiveSupport::TestCase
  class IsValidCombination < DressTypeBadComboTest
    test "valid combination" do
      assert Dress.find(1).is_valid_combination?, "dress one is valid"
    end
    test "invalid combination" do
      assert_not Dress.find(2).is_valid_combination?, "dress one is valid"
    end
  end
end
