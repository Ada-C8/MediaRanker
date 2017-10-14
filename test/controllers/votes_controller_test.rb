require "test_helper"

describe VotesController do
  describe "create" do
    it "can tell if a user is logged in" do
      
    end

    it "should create a new Vote if input is valid" do
      proc { post votes_path, params: { user: users(:user1), work: works(:movie1) } }.must_change 'Vote.count', 1
      must_respond_with :redirect
    end

    it "won't add a Vote if user has already voted (invalidity)" do
      proc { post votes_path, params: { user: users(:user1), work: works(:album1) } }.must_change 'Vote.count', 0
    end
  end
end
