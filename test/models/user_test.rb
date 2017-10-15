require "test_helper"

describe User do
  it "recognizes a user as valid" do
    users(:test_user).valid?.must_equal true
  end

  it "does not recognize a user without a username as valid" do
    users(:no_username).valid?.must_equal false
    users(:no_username).username = "hereitis"
    users(:no_username).save
    users(:no_username).valid?.must_equal true
  end

  it "will not allow a user with a duplicate username to be valid" do
    user = User.new(username: "testing")
    user.save
    user.valid?.must_equal true
    another = User.new(username: "testing")
    another.save
    another.valid?.must_equal false
  end
end
