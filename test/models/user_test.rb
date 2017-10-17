require "test_helper"

describe User do
  let(:user) { User.new }
  let(:user1) { users(:user1) }

  it "must be valid" do
    user1.must_be :valid?
  end

  it "must have a username" do
    user.username = "   "
    user.valid?.must_equal false

    user.username = "Name"
    user.valid?.must_equal true
  end

  it "must be unique" do
    user1.username.must_equal "rainbow"
    user.username = "rainbow"
    user.valid?.must_equal false
  end
end
