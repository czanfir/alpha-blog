require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "sports")
    @admin_user = User.create(username: "test", email: "test@test.com", password:"test", admin: true)
  end
  
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id] = @admin_user.id #simulate that we have logged in as created admin_user
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {id: @category.id})
    assert_response :success
  end
  
  test "should redirect when admin not logged in" do
    assert_no_difference 'Category.count' do
      post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end
end