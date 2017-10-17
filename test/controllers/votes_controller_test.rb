require "test_helper"

describe VotesController do
  describe "create" do
    let(:user1) { users(:user1) }
    let(:movie1) { works(:movie1) }
    # let(:login) { post login_path, params: {name: user1.username} }

    #TODO I can't figure out how to have a session running during testing
    def login
      post login_path, params: {name: user1.username}
    end

    it "can tell if a user is logged in" do

    end

    it "should create a new Vote if input is valid" do
      puts "COUNT: #{Vote.count}"
      login
      post votes_path, params: { work: movie1 }
      puts "COUNT: #{Vote.count}"

      proc { post votes_path, params: { user: users(:user1), work: works(:movie2) } }.must_change 'Vote.count', 1


      must_respond_with :redirect
    end

    it "won't add a Vote if user has already voted (invalidity)" do
      proc { post votes_path, params: { user: users(:user1), work: works(:album1) } }.must_change 'Vote.count', 0
    end
  end
end
