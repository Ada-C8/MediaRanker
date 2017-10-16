require "test_helper"
#
# describe VotesController do
#   it "should get index" do
#     get votes_index_url
#     value(response).must_be :success?
#   end
#
# end


describe VotesController do
  describe "create" do
    it "creates a new vote" do
      # Arrange
      vote_data = {
        vote: {
          user_id: 1,
          work_id: 2
        }
      }

      Vote.create(vote_data[:vote]).must_be :valid?

      start_vote_count = Vote.count

      # Act
      post votes_path, params: vote_data

      # Assert
      must_respond_with :redirect
      must_redirect_to votes_path

      Vote.count.must_equal start_vote_count + 1
    end #adds work test
  end #r
end #all Vote tests
