require 'test_helper'

class DressTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dress_type = dress_types(:one)
  end

  test "should get index" do
    get dress_types_url, as: :json
    assert_response :success
  end

  test "should create dress_type" do
    assert_difference('DressType.count') do
      post dress_types_url, params: { dress_type: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show dress_type" do
    get dress_type_url(@dress_type), as: :json
    assert_response :success
  end

  test "should update dress_type" do
    patch dress_type_url(@dress_type), params: { dress_type: {  } }, as: :json
    assert_response 200
  end

  test "should destroy dress_type" do
    assert_difference('DressType.count', -1) do
      delete dress_type_url(@dress_type), as: :json
    end

    assert_response 204
  end
end
