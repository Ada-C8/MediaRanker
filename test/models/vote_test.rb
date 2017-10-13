require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:user) { users(:one) }
  let(:album) { works(:album) }
  let(:book) { works(:book) }

  it "requires a work_id and user_id to be valid" do
    vote.valid?.must_equal false, "Vote must be invalid with nil for both work_id and user_id"
    vote.user_id = user.id
    vote.valid?.must_equal false, "Vote must be invalid with work_id = nil"
    vote.user_id = nil
    vote.work_id = album.id
    vote.valid?.must_equal false, "Vote must be invalid with user_id = nil"
    vote.user_id = user.id
    vote.valid?.must_equal true, "Vote must be valid with non-nil values for work_id and user_id"
  end

  it "requires a unique set of work_id and user_id to be valid" do
    first_vote = Vote.new(user_id: user.id, work_id: album.id)
    proc{ first_vote.save }.must_change 'Vote.count', +1
    vote.user_id = user.id
    vote.work_id = album.id
    vote.save.must_equal false
    vote.work_id = book.id
    proc{ vote.save }.must_change 'Vote.count', +1
  end
end
