require "test_helper"

describe SessionsController do
  it "must be able to load the login page" do
    get login_path
    must_respond_with :success
  end

  it "creates a new user if the username doesn't already exit" do
    proc {
      post login_path, params: { username: "Ada Lovelace"}
    }.must_change 'User.count', 1

    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "recognizes an existing user name and logs in as that user without creating a new user" do
    proc {
      post login_path, params: { username: "Heather Michelle" }
    }.must_change 'User.count', 1

    proc {
      post login_path, params: { username: "Heather Michelle"}
    }.must_change 'User.count', 0

    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "keeps track of the users login status through sessions" do
    post login_path, params: { username: "Carol Kay"}

    user_id = User.find_by(name: "Carol Kay").id

    session[:user_id].must_equal user_id

    get works_path
    work = Work.find( works(:movie).id )
    get work_path(work)

    session[:user_id].must_equal user_id
  end

  #Probably not necessary as a test after the previous one, but learning how session works
  it "clears the session if someone logs out" do
    post login_path, params: { username: "Nathan"}
    user_id = session[:user_id]
    user = User.find(user_id)
    user.name.must_equal "Nathan"

    post logout_path
    session[:user_id].must_be_nil

    must_respond_with :redirect
    must_redirect_to root_path
  end

  it "keeps the username as a User after the uesr logs out" do
    post login_path, params: { username: "Richard"}

    post logout_path

    user = User.find_by(name: "Richard")
    user.name.must_equal "Richard"
  end
end
