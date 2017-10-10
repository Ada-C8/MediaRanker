require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  it "must be valid" do
    votes(:one).must_be :valid?
  end
end
