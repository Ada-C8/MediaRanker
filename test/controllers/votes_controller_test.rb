require "test_helper"

describe VotesController do
  let(:vote) { Vote.new }
  let(:user) { users(:one) }
  let(:album) { works(:album) }
  let(:book) { works(:book) }

  it "must create a vote with valid parameters when the user is logged in" do
    skip
    # need to test logging in first
    # proc { post create_vote_path(user.id, album.id) }.must_change 'Vote.count', +1
    # must_respond_with :redirect
  end

  it "must not create a vote with invalid parameters" do
    skip
  end
end
