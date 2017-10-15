require "test_helper"

describe Vote do

  it "must be valid" do
    votes(:vote_one).must_be :valid?
  end
end
