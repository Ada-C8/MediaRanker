require "test_helper"

describe Vote do
  let(:vote) {votes(:one)}

  it "must be valid" do
    vote.valid?.must_equal true
  end

end
