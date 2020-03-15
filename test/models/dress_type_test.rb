require 'test_helper'

class DressTypeTest < ActiveSupport::TestCase
  test "create user" do
    test_dress_type = DressType.create name: "new beginnings", image: "foo bar"
    found_user = DressType.find_by_name "new beginnings"
    assert found_user.image == "foo bar"
  end

  test "unique name" do
    test_dress_type = DressType.create name: "new beginnings", image: "foo bar"
    error = false
    begin
      dupe_dress = DressType.create name: "new beginnings", image: "omega alpha"
    rescue => err
      error = err
    end

    assert err.message =~ %r{duplicate key value} ? 'yes' : 'no'
  end

  test "features" do
    test_dress_type = DressType.create name: "new beginnings", image: "foo bar"
    test_dress_type.add_feature_value 'color', 'white'
    test_dress_type.add_feature_value 'color', 'red'
    test_dress_type.save

    found_dress = DressType.find_by_name "new beginnings"
    assert found_dress.feature_list == {"color" => Set.new(["white", "red"])}
  end

  class AddFeaturesTest < DressTypeTest
    test "add several" do
      first_dress_type = DressType.find(1)

      first_dress_type.add_features([
                                        {"name" => "size", "options" => ["small", "medium", "large"]},
                                        {"name" => "sleeves", "options" => ["short", "long"]}
                                    ])

      assert first_dress_type.feature_list == {"color" => Set.new(["white"]), "trim" => Set.new(["simple"]), "size" => Set.new(["small", "medium", "large"]), "sleeves" => Set.new(["short", "long"])}


    end
  end

end
