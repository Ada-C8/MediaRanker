require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    users(:one).must_be :valid?
  end

  it "must only accept a user with email formatting" do
    g = User.new(name: "Joe", email: "an email")
    g.wont_be :valid?
    g[:email] = "joeschmoe@somemail.com"
    g.must_be :valid?
  end
end
