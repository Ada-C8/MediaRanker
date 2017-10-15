require "test_helper"

describe UsersController do
  let(:user1) { users(:user1) }

  describe "CRUD methods" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end

    describe "show" do
      it "should get user detail page (#show) or render a 404" do
        get user_path(user1.id)
        must_respond_with :success
      end

      it "will render 404 page if id isn't found" do
        get user_path(User.last.id + 1)
        must_respond_with :not_found
      end
    end #show

  end #

end
