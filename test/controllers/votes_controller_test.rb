require "test_helper"

describe VotesController do

    # it "should successfully gets to index path" do
    #   get votes_path
    #   must_respond_with :success
    # end

    it "should be able to create a new vote" do
      username = users(:test_user).username
      Session.login
      post votes_path, params: {vote: {work_id: works(:test_book).id}}
      must_respond_with :redirect
      must_redirect_to redirect_to work_path(params[:work_id])

      proc   {
        post votes_path, params: {vote: {user_id: users(:test_user).id, work_id: works(:test_book).id} }
      }.must_change 'Vote.count', 1
    end

end
