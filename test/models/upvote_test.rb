require "test_helper"

describe Upvote do
  let(:upvote) { Upvote.new }

  it "empty upvote must be invalid" do
    upvote.valid?.must_equal false
  end
end
