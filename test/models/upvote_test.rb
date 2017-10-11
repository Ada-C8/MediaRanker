require "test_helper"

describe Upvote do
  let(:upvote) { Upvote.new }
  let(:vote) { upvotes(:one) }
  it "empty upvote must be invalid" do
    upvote.valid?.must_equal false
  end
  it "upvote should be valid with both ids" do
    vote.valid?.must_equal true
  end
  it "upvote is invalid with missing id" do
    vote.work_id = nil
    vote.valid?.must_equal false
  end
  it "upvote is invalid with missing id" do
    vote.user_id = nil
    vote.valid?.must_equal false
  end
end
