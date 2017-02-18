require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
    
  #use create here because that way ruby creates and saves in the test db
  def setup
    @user = User.create(username: "Batz", email: "batz@gotham.com", password: "password", admin: true)
  end
  
  #this test will check all steps of how a category is actually created
  test "get new category form and create category" do
    #method that simulates a user signing in because 
    #integration does not have access to the sessions from controller
    #the function is created in *test/test_helper.rb
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failiure" do
    #method that simulates a user signing in because 
    #integration does not have access to the sessions from controller
    #the function is created in *test/test_helper.rb
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    #looking for the errors by finding the defining div classes of this error messages
    #*views/shared/errors.html.erb
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end