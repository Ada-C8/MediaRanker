require "test_helper"

describe User do
  let(:harry) { users(:harry) }

  it "must be valid" do
    harry.valid?.must_equal true
  end

  it "must only allow unique usernames" do
    dup_user = User.new(name: users(:harry).name)
    dup_user.valid?.must_equal false

    dup_user.name = "New name"
    dup_user.valid?.must_equal true
  end
end
