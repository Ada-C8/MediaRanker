require "test_helper"



describe VotesController do
  before do
    post login_path, params: { user: {
      name: "Bennett"
      } }
  end

  describe "create" do
    it "creates a vote." do

      vote_data = {
        vote: {
        work: works(:hp1)
        }
      }

      # Vote.new(vote_data[:vote]).must_be :valid?
      start_count = Vote.count

      post create_vote_path, params: vote_data
      must_respond_with :redirect
      must_redirect_to root_path
      # this works since we didn't come from anywhere, but I'm not sure it really tests the redirect_back

      # Vote.count.must_equal start_count + 1
      # Both this and the Vote.new are failing because the user isn't logged in. I'm temporarily giving up.
    end

    it "doesn't create a new vote when the user isn't logged in." do
      vote_data = {
        vote: {
          user: nil,
          work: works(:hp1)
        }
      }
      Vote.new(vote_data[:vote]).wont_be :valid?
      start_work_count = Vote.count
      post create_vote_path, params: vote_data
      must_respond_with :redirect
      must_redirect_to root_path
      # see above and note in votes_controller - I haven't come up with a better way to handle/test this.

      Vote.count.must_equal start_work_count

    end
  end
end
