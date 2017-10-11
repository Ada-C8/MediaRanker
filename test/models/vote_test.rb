require "test_helper"

describe Vote do
  let(:vote) {votes(:one)}

  it "will be valid when user and work are present" do
    vote.valid?.must_equal true
  end

  it "will not be valid unless user is present" do
    vote.user = nil
    vote.valid?.must_equal false
    vote.errors.must_include :user
  end

  it "will not be valid unless a work is present" do
    vote.work = nil
    vote.valid?.must_equal false
    vote.errors.must_include :work
  end

end
