require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "create user" do
    test_user = User.create user_name:"fred", path: "alpha-path"
    found_user = User.find_by_user_name "fred"
    assert found_user.path == "alpha-path"
  end

  test "unique username" do
    test_user = User.create user_name:"fred", path: "alpha-path"
    error = false
    begin
      second_user = User.create user_name: "fred", path: "beta-path"
    rescue => err
      error = err
    end

    assert err.message =~ %r{duplicate key value} ? 'yes' : 'no'
  end

end
