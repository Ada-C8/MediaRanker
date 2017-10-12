require "test_helper"

describe VotesController do

    # it "should successfully gets to index path" do
    #   get votes_path
    #   must_respond_with :success
    # end

    it "should be able to create a new vote" do
      post votes_path, params: {vote: {user_id: 5, work_id: 1}}
      must_respond_with :redirect
      must_redirect_to redirect_to work_path(params[:work_id])

      proc   {
        post votes_path, params: {vote: {user_id: 99, work_id: 1}}
      }.must_change 'Vote.count', 1
    end

end
