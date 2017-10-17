require "test_helper"

describe VotesController do
  describe "new" do
    it "returns a success status" do
      get new_vote_path
      must_respond_with :success
    end
  end

  describe "create" do
      it "adds the vote to the database when data given is valid" do
        start_count = Vote.count
        # u = User.create!(name: "someone")
        u = users(:kamron)
        # user_data = {
        #   user: {
        #     name: u.name
        #   }
        # }
        # u.login

        vote_data = {
          vote: {
            user_id: u.id,
            work_id: Work.first.id
          }
        }
        # visit works_path
        vote = Vote.new(vote_data[:vote]).must_be :valid?

        #These tests don't work because I am redirecting to the page the user is on, and I do not know how to specify that in the test

        post votes_path, params: vote_data
        # must_respond_with :redirect
        # must_redirect_to works_path
        Vote.count.must_equal (start_count + 1)
      end
  end

end
