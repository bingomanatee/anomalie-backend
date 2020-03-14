require 'test_helper'

class DressTypeTest < ActiveSupport::TestCase
  test "create user" do
    test_dress = DressType.create name: "new beginnings", image: "foo bar"
    found_user = DressType.find_by_name "new beginnings"
    assert found_user.image == "foo bar"
  end

  test "unique name" do
    test_dress = DressType.create name: "new beginnings", image: "foo bar"
    error = false
    begin
      dupe_dress = DressType.create name: "new beginnings", image: "omega alpha"
    rescue => err
      error = err
    end

    assert err.message =~ %r{duplicate key value} ? 'yes' : 'no'
  end

  test "features" do
    test_dress = DressType.create name: "new beginnings", image: "foo bar"
    test_dress.dress_type_features << DressTypeFeature.new({name: 'color', value: 'white'})
    test_dress.dress_type_features << DressTypeFeature.new({name: 'color', value: 'red'})
    test_dress.save

    found_dress = DressType.find_by_name "new beginnings"
    assert found_dress.feature_list == {"color" => ["white","red"]}
  end

end
