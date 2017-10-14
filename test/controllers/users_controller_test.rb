require "test_helper"

describe UsersController do
  let(:user1) { users(:user1) }

  describe "CRUD methods" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end

    it "should display a form for a new User" do
      get new_user_path
      must_respond_with :success
    end

    describe "create" do
      it "should create a new User if input is valid" do
        proc { post users_path, params: { user: { username: "A Name" } } }.must_change 'User.count', 1
        must_respond_with :redirect
      end

      it "re-renders the new form if input is invalid" do
        proc { post users_path, params: { user: { username: nil } } }.must_change 'User.count', 0
        must_respond_with :bad_request
      end
    end #create

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
