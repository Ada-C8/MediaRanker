require "test_helper"

describe VotesController do
  describe "upvote" do
    it "a new user can upvote a work if they are logged in" do
      # # Arrange
      before_count = Vote.count
      new_username = "new username"
      post login_path, params: { username: new_username }
      # # Act
      post votes_path(work_id: Work.first.id)
      # # Assert
      Vote.count.must_equal before_count + 1
      must_respond_with :found
    end


    it "a logged in user cannot vote for a work they have already voted for"do
      # # Arrange
      new_username = "new username"
      post login_path, params: { username: new_username }
      post votes_path(work_id: Work.first.id)
      before_count = Vote.count
      # # Act
      post votes_path(work_id: Work.first.id)
      # # Assert
      Vote.count.must_equal before_count
      flash[:status].must_equal :failure
    end

    it "a user cannot vote for a work unless they are signed in"do
      before_count = Vote.count
      post votes_path(work_id: Work.first.id)
      flash[:status].must_equal :failure
      Vote.count.must_equal before_count
    end
  end
end
