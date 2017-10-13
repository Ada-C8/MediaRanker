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

  it "must be unique" do
    new_vote = Upvote.new(user_id: vote.user_id, work_id: vote.work_id)
    new_vote.valid?.must_equal false
  end

  it "Users can have multiple work_ids" do
    new_vote = Upvote.new(user_id: vote.user_id, work_id: works(:hp).id)
    new_vote.valid?.must_equal true
  end

  it "Works can have multiple user_ids" do
    new_vote = Upvote.new(user_id: users(:dex).id, work_id: vote.work_id)
    new_vote.valid?.must_equal true
  end

  it "has user relations" do
    vote.user.must_equal users(:averi)
    vote.work.must_equal works(:fifty)
  end
end
