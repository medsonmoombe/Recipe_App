require 'test_helper'

class FoodlistControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get foodlist_index_url
    assert_response :success
  end

  test 'should get new' do
    get foodlist_new_url
    assert_response :success
  end

  test 'should get show' do
    get foodlist_show_url
    assert_response :success
  end
end
