require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    user.name = "Averi"
    value(user).must_be :valid?
  end
  it "is invalid without a name" do
    user.valid?.must_equal false
    user.name = ""
    user.valid?.must_equal false
  end
end
