require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:work) { Work.new }
  let(:vote_1) { votes(:vote_1)}

  it "must have a valid work and user to be valid" do
    vote.valid?.must_equal false
    vote.errors.keys.must_include :user, :work
    vote.errors[:work].must_equal ["must exist"]
    vote.errors[:user].must_equal ["must exist"]
    vote.work = works(:bonito)
    vote.save.must_equal false
    vote.errors.keys.must_include :user, :work
    vote.errors[:user].must_equal ["must exist"]
    vote.user = users(:crisco)
    vote.valid?.must_equal true
  end
end
