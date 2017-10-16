require './test/test_helper'

=begin
1 test for each custom model method
1 test for each relationship
2 tests for validation
2 tests on scope
=end

describe User do
  it "must be invalid" do
    user = User.new
    result = user.valid?
    result.must_equal false
    #value(user).must_be :valid?
  end

  it "must be valid" do
    user = User.new
    user.name = 'John'
    user.joined_on = 2017-10-01
    result = user.valid?
    result.must_equal true
  end


end
