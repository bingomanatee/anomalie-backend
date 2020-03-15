require 'test_helper'

class DressTypesBadCombosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dress_types_bad_combo = dress_type_bad_combos(:one)
  end

  test "should get index" do
    get dress_types_bad_combos_url, as: :json
    assert_response :success
  end

  test "should create dress_types_bad_combo" do
    assert_difference('DressTypeBadCombo.count') do
      post dress_types_bad_combos_url, params: {dress_type_bad_combo: {:dress_type_id =>  DressType.first.id}}, as: :json
    end

    assert_response 201
  end

  test "should show dress_types_bad_combo" do
    get dress_types_bad_combos_url(@dress_types_bad_combo), as: :json
    assert_response :success
  end

  test "should update dress_types_bad_combo" do
    patch dress_types_bad_combos_url(@dress_types_bad_combo).sub('combos.', 'combos/'), params:  {dress_type_bad_combo: {:id  => @dress_types_bad_combo.id}}, as: :json
    assert_response 200
  end

  test "should destroy dress_types_bad_combo" do
    assert_difference('DressTypeBadCombo.count', -1) do
      delete dress_types_bad_combos_url(@dress_types_bad_combo).sub('combos.', 'combos/'), as: :json
    end

    assert_response 204
  end
end

