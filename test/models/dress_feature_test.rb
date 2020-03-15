require 'test_helper'

class DressFeatureTest < ActiveSupport::TestCase

  test "fixtures" do
    dress = Dress.find 1

    assert dress.feature_list == {"color" => Set.new(["white"]), "trim" => Set.new(["plain"])}
  end

  test "has_features - positive" do
    dress = Dress.find 1
    assert dress.has_features?({"color" => ["white"]})
  end

  class HasFeatures < DressFeatureTest

    test "can find match" do
      dress = Dress.find 1
      assert dress.has_features?({"color" => ["white"]})
      assert dress.has_features?({"trim" => ["plain"]})
    end

    test "fails bad features" do
      dress = Dress.find 1
      assert_not dress.has_features?({"color" => ["red"]})
      assert_not dress.has_features?({"trim" => ["white"]})
    end

    test "multi feature match" do
      dress = Dress.find 1
      assert dress.has_features?({"trim" => ["plain"], "color" => "white"})
    end
  end
end
