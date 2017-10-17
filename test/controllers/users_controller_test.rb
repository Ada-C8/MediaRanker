require "test_helper"

describe UsersController do
  describe "User Index" do
    it "should get index" do
      get users_url
      assert_response :success
    end
  end


  describe "User Show" do
    it "should get the show page of a single user" do
      get user_path(users(:potato).id)
      assert_response :success
    end

    it "should redirect to 404 page if user goes to a non-existent user's show page" do
      get user_path(9999)
      assert_response :redirect
      must_redirect_to "/404.html"
    end
  end

end
