require './test/test_helper'

=begin
1 test for each custom model method
1 test for each relationship
2 tests for validation
2 tests on scope
=end

describe Vote do
  it "must be invalid" do
    vote = Vote.new
    result = vote.valid?
    result.must_equal false
    #value(user).must_be :valid?
  end

  it "must be valid" do
    vote = Vote.new
    vote.work_id = 1
    vote.user_id = 1
    vote.category = 'album'
    result = vote.valid?
    result.must_equal true
  end


end
