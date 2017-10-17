require "test_helper"

describe User do

  it "must be valid if it has a username" do
    users(:user_one).must_be :valid?
  end

  it "must have a username" do
    user_two = users(:user_two)

    user_two.username = ""

    (user_two.valid?).must_equal false
  end

  it "can have votes" do
    movie = works(:movie_one)
    user = users(:user_two)
    @vote = Vote.new
    @vote.work = movie
    @vote.user = user
    @vote.save

    ((user.votes).last).id.must_equal @vote.id
  end
end
