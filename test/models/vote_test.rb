require "test_helper"

describe Vote do
  # let allows you to refer to the curly brace content as vote
  let(:vote) { votes(:one) }

  it "must be valid" do
    value(vote).must_be :valid?
  end

  it "Should require a user id" do
    vote.user_id = nil
    vote.valid?.must_equal false
  end

  it "Should require a work id" do
    vote.work_id = nil
    vote.valid?.must_equal false
  end

  it "should return the media with the highest number votes" do
    Vote.media_spotlight.must_equal (works(:two))
  end


  it "should return the media with the highest number votes" do
    Vote.media_spotlight.must_equal (works(:two))
  end


end
