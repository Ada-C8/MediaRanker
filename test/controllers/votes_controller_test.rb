require "test_helper"

describe "VotesController" do

  let(:vote) { Vote.new }
  let(:fanGirl) { users(:fanGirl) }
  let(:fanBoy) { users(:fanBoy) }
  let(:harry_potter) { works(:harry_potter) }
  let(:one) { users(:one) }
  let(:two) { users(:two) }

  it "can't vote if not logged in" do
    proc { post work_votes_path(works(:twilight).id)}.must_change 'Vote.count', 0
    flash[:error].must_equal "Must be logged in to vote"
  end

  it "logged in and vote, vote count increases by one" do
    post login_path, params: {name: users(:fanGirl).name}
    proc {post work_votes_path(works(:harry_potter).id)}.must_change 'Vote.count', +1
    must_respond_with :redirect
    flash[:success].must_equal "Successfully upvoted!"
  end

  it "cannot vote with invalid inputs" do
    post login_path, params: {name: users(:fanGirl).name}
    proc { post work_votes_path(-2)}.must_change 'Vote.count', 0
    flash[:error].must_equal "Vote not recorded"
  end

  it "same user can't vote for same work twice" do
    post login_path, params: {name: users(:fanGirl).name}
    post work_votes_path(works(:harry_potter).id)
    proc { post work_votes_path(works(:twilight).id)}.must_change 'Vote.count', 0
    flash[:error].must_equal "Vote not recorded"
  end


end
