require "test_helper"

describe Vote do

  describe "relationships" do
    it "can access users" do
      u = users(:tanja)
      u.votes.count.must_equal 2
    end
  end

  describe "validations"do

  it "vote must be valid for user and related work" do
    vote = votes(:vote1)
    vote.valid?.must_equal true
  end

  it "is not valid if no params" do
    vote = Vote.new
    vote.valid?.must_equal false
  end

  it "is not valid with work missing" do
    vote = Vote.new(user: users(:tanja))
    vote.valid?.must_equal false
  end

  it "is not vaid with user missing" do
    vote = Vote.new(work: works(:baby))
    vote.valid?.must_equal false
  end

  it "only one vote per work per user" do
    vote = Vote.new(work: works(:conroy), user: users(:tanja))
    vote.valid?.must_equal true
    vote.save

    vote2 = Vote.new(work: works(:conroy), user: users(:tanja))
    vote2.valid?.must_equal false
  end

end
end
