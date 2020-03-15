require 'test_helper'

class DressTest < ActiveSupport::TestCase
  test "dress from type" do
    test_dress_type = DressType.create name: "new beginnings", image: "foo bar"
    test_dress_type.add_feature_value 'color', 'white'
    test_dress_type.add_feature_value 'trim', 'fancy'
    test_dress_type.save

    test_user = User.create user_name: "Rachel", path: "rachel-path"

    test_dress = Dress.create user: test_user, dress_type: test_dress_type
    test_dress.add_feature_value("color", "white")
    test_dress.add_feature_value("trim", "plain")
    test_dress.save

    test_dress_2 = Dress.create user: test_user, dress_type: test_dress_type
    test_dress_2.add_feature_value("color", "red")
    test_dress_2.save

    rachel = User.find_by_user_name "Rachel"

    assert rachel.dresses.count == 2
    assert rachel.has_dress? "new beginnings", {"color" => ["white"]}
  end

end
