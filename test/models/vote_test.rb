require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  it "must have user_id" do
    vote = votes(:one)
    vote.user = nil
    vote.save.must_equal false
    vote.user = users(:mark)
    vote.save.must_equal true
  end

  it "must have work id" do
    vote = votes(:one)
    vote.work = nil
    vote.save.must_equal false
  end

  it "can make a vote" do
    vote = Vote.new(work: works(:wilco), user: users(:mark))
    vote.save.must_equal true
  end

  it "has a user" do
    vote = votes(:two)
    vote.user.must_equal users(:mark)
  end

  

end
