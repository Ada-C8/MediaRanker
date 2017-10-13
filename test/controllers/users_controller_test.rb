require "test_helper"

describe UsersController do
  it "should successfully get to users index page" do
    get users_path
    must_respond_with :success
  end

  it "should successfully get to user show page" do
    get user_path(users(:test_user).id)
    must_respond_with :success
  end

  # it "should successfully get new page" do
  #   get new_work_path
  #   must_respond_with :success
  # end

  it "should be able to create a new user" do
    post users_path, params: {user: {username: "testingitout"}}
    must_respond_with :redirect
    must_redirect_to users_path

    proc   {
      post users_path, params: {user: {username: "checkingitout"}}
    }.must_change 'User.count', 1
  end

  # trying to show a user that doesnt exist should respond with not_found


  #
  # it "should successfully delete work" do
  #   delete work_path(works(:test_book).id)
  #   must_respond_with :redirect
  #   must_redirect_to works_path
  #
  #   proc   {
  #     delete work_path(works(:another_test).id)
  #   }.must_change 'Work.count', -1
  # end

end
