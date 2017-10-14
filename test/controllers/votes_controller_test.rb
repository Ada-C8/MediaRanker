require "test_helper"

describe VotesController do
  describe "create" do
    it "can successfully create a vote" do
      work_id = Work.first.id
      vote_count = Vote.count
      post login_path, params: { name: User.first.name }

      post create_vote_path(work_id)
      must_respond_with :redirect
      must_redirect_to works_path
      Vote.count.must_equal vote_count + 1
    end

    it "will not allow user to vote twice" do
      work_id = Work.first.id
      vote_count = Vote.count
      post login_path, params: { name: User.first.name }

      post create_vote_path(work_id)
      post create_vote_path(work_id)
      Vote.count.must_equal vote_count + 1
    end

    it "will not allow a user to vote unless logged in" do
      work_id = Work.first.id
      vote_count = Vote.count
      post login_path, params: { name: nil}
      post create_vote_path(work_id)

      Vote.count.must_equal vote_count
    end

  end
end
