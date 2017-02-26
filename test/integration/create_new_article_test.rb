require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "milka", email: "milka@milk.com", password: "password")
  end
  
  test 'get new article' do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: "tester", description: "something something long to describe here"}
    end
    assert_template 'articles/show'
    assert_match "tester", response.body
  end
  
end