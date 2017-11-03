require "test_helper"

describe SessionsController do

  describe "auth_callback_path" do
    describe "auth_callback" do
      it "should log in an existing user and redirects them back to the homepage" do
        start_count = User.count
        user = users(:crisco)


        log_in(user, :github)

        must_respond_with :redirect
        must_redirect_to root_path
        User.count.must_equal start_count
        session[:user_id].must_equal user.id
      end

      it "can log in a new user" do
        start_count = User.count
        user = User.new name: "Greg", provider: 'github', email: 'RapMonster@naver.com'
        user.uid = 901
        log_in(user, :github)

        must_respond_with :redirect
        must_redirect_to root_path
        User.count.must_equal (start_count + 1)
        saved_user = User.find_by(name: "Greg")
        session[:user_id].must_equal saved_user.id
      end

      it "can logout a user" do
        log_in(users(:crisco), :github)
        session[:user_id].must_equal users(:crisco).id
        get root_path

        post logout_path
        must_respond_with :redirect
        must_redirect_to root_path
      end

      it "succeeds if the user is not logged in" do
        post logout_path
        must_redirect_to root_path
      end
  end
end
end
# =>  login_path is no longer used with oauth implementation
# it "going to the login_form page is successful" do
#   get login_path
#   must_respond_with :success
# end
#
# it "should be able to create a user" do
#   proc {
#     post login_path, params: {username: "alyssa"}
#   }.must_change 'User.count', 1
#   must_respond_with :redirect
#   must_redirect_to root_path
# end
#
# it "should be able to login as an existing user" do
#   proc {
#     post login_path, params: {username: users(:crisco).name}
#   }.must_change 'User.count', 0
#   must_respond_with :redirect
#   must_redirect_to root_path
#   session[:user_id].must_equal users(:crisco).id
# end
#
# it "should not create a user if name is not given" do
#   proc {
#     post login_path, params: {username: nil}
#   }.must_change 'User.count', 0
#   flash[:error].must_equal "User not logged in successfully"
#
# end
#
# it "should logout" do
#   post login_path, params: {username: users(:crisco).name}
#   session[:user_id].must_equal users(:crisco).id
#   post logout_path
#   session[:user_id].must_equal nil
#   must_redirect_to root_path
#   flash[:success].must_equal "Successfully logged out"
# end
