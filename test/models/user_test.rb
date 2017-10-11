require "test_helper"

describe User do
  let(:user) { User.new }

  it "must have a unique name to be valid" do
    user.valid?.must_equal false
    user.username = "username"
    user.save.must_equal true
    another_user = User.new(username: "username")
    another_user.valid?.must_equal false
  end
end
