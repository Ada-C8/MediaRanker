require "test_helper"

describe UsersController do

  # describe  "new" do
  #   it "works" do
  #     user = {
  #       user: {
  #         oauth_provider: "github",
  #         oauth_uid: "4883904",
  #         email: "some@somesite.com",
  #         name: "Someone"
  #       }
  #     }
  #     start_count = User.all.count
  #     User.new(user[:user]).must_be :valid?
  #     get new_user_path, params: user
  #     binding.pry
  #     flash[:status].must_equal :success
  #     flash[:message].must_include "Successfully created user"
  #     must_respond_with :redirect
  #     must_redirect_to root_path
  #     User.all.count.must_equal start_count + 1
  #   end
  # end

  describe "create" do
    it "works" do
      user = {
        user: {
          oauth_provider: "github",
          oauth_uid: "4883904",
          email: "some@somesite.com",
          name: "Someone"
        }
      }
      start_count = User.all.count
      User.new(user[:user]).must_be :valid?
      post users_path, params: user
      flash[:status].must_equal :success
      flash[:message].must_include "Successfully created user"
      must_respond_with :redirect
      must_redirect_to root_path
      User.all.count.must_equal start_count + 1
    end


    it "re-renders form when the user data is invalid" do
      user = {
        user: {
          oauth_provider: "github",
          oauth_uid: "",
          email: "somebodyelse@somesite.com",
          name: "Somebody_else"
        }
      }
      User.new(user[:user]).wont_be :valid?
      start_count = User.count

      post users_path, params: user

      must_respond_with :bad_request
      User.count.must_equal start_count
    end
  end

  describe "update" do

    it "returns success if the user ID is valid and the change is valid" do
      user = User.first
      user_data = {
        user: {
          name: "changed username",
          email: user.email
        }
      }
      user.update_attributes(user_data[:user])
      user.must_be :valid?, "Test is invalid because the provided data will produce an invalid user"

      patch user_path(user), params: user_data

      must_respond_with :redirect
      must_redirect_to root_path

      # Check that the change went through
      user.reload
      user.name.must_equal user_data[:user][:name]
    end
  end


  describe "edit" do
    it "succeeds for an extant user ID" do
      get edit_user_path(User.first)
      must_respond_with :success
    end
    it "renders 404 not_found for a bogus user ID" do
      bogus_user_id = User.last.id + 1
      get edit_user_path(bogus_user_id)
      must_respond_with :not_found
    end
  end

  describe "logout" do
    it "works" do
      login_test_user
      get logout_path
      session[:user].must_equal nil
      must_redirect_to root_path
    end

  end

  describe "login" do
    it "logs in an existing user and redirects to the root route" do
      start_count = User.all.count

      user = users(:one)
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      get login_path(:github)

      must_redirect_to root_path

      session[:user][:id].must_equal user.id

      User.all.count.must_equal start_count
    end

    it "creates new user with new info" do

      start_count = User.all.count
      new_user = User.new(oauth_provider: 'github',oauth_uid: "adlgkcl",email: 'mail@mail.com', name: 'Mr. New')
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_user))
      get login_path(:github)
      must_redirect_to root_path
      User.count.must_equal start_count + 1
      session[:user][:id].must_equal User.last.id
      # flash[:result_text].must_equal "Successfully created new user "
      # flash[:status].must_equal :success
    end

    it "generates failure with no info" do
      start_count = User.all.count
      OmniAuth.config.mock_auth[:github] = nil
      get login_path(:github)
      User.count.must_equal start_count
      flash[:result_text].must_equal "Not logged in"
      flash[:status].must_equal :failure
      flash[:messages].must_include :email
      flash[:messages].must_include :name
      must_redirect_to root_path
    end
  end

end
