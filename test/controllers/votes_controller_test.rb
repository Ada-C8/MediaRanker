require "test_helper"

describe VotesController do

    # it "should successfully gets to index path" do
    #   get votes_path
    #   must_respond_with :success
    # end

    it "should be able to create a new vote" do

      @user = users(:test_user)
      @work = works(:test_book)

      # @work = works(:test_book).id

      post votes_path
      must_respond_with :redirect
      must_redirect_to work_path(params[:work_id])

      proc   {
        post votes_path
      }.must_change 'Vote.count', 1
    end

end
