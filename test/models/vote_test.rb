require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:one) { votes(:one) }
  let(:two) { votes(:two) }
  let(:twilight) { works(:twilight) }
  let(:harry_potter) { works(:harry_potter) }

  it "must have a user" do
    one.valid?.must_equal true
    one.user = nil
    one.valid?.must_equal false
    one.errors[:user].must_equal ["must exist"]
  end

  it "must have a work" do
    two.valid?.must_equal true
    two.work = nil
    two.valid?.must_equal false
    two.errors[:work].must_equal ["must exist"]
  end

  it "work must contain the proper number of votes" do
    twilight.votes.count.must_equal 2
    harry_potter.votes.count.must_equal 0
  end
end
