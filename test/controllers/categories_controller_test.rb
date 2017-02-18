require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  #use create here because that way ruby creates and saves in the test db
  def setup
    @category = Category.create(name: "pellegrino")
  end
  
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  #show requires an object therefor an id of the object
  #the object was created in the setup def
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
end