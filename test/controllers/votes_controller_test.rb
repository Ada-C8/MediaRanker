require "test_helper"

describe VotesController do
  it "able to vote when logged in" do
    proc   {
      post login_path(name: "gogol bordello")
      post vote_path(works(:relaxer).id)
    }.must_change 'Vote.all.count', 1
  end

  it "should not be able to vote when logged out " do
    proc   {
      post login_path(name: "")
      post vote_path(works(:baby).id)
    }.must_change 'Vote.all.count', 0
  end

  it "can't vote on the same work multiple times" do
    proc   {
      post login_path(name: "gogol bordello")
      post vote_path(works(:baby).id)
      post vote_path(works(:baby).id)
      post vote_path(works(:baby).id)
    }.must_change 'Vote.all.count', 1
  end

  it "should be able to vote for a movie" do
    proc   {
      post login_path(name: "gogol bordello")
      post vote_path(works(:conroy).id)
    }.must_change 'Vote.all.count', 1
  end

  it "should be able to vote for a album" do
    proc   {
      post login_path(name: "gogol bordello")
      post vote_path(works(:relaxer).id)
    }.must_change 'Vote.all.count', 1
  end

  it "should be able to vote for a book" do
    proc   {
      post login_path(name: "gogol bordello")
      post vote_path(works(:baby).id)
    }.must_change 'Vote.all.count', 1
  end
end
