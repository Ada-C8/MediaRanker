require "test_helper"

describe VotesController do

  describe "new" do

    it "returns a success status" do
      get new_vote_path
      must_respond_with :success
    end

  end

end
