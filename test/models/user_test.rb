require "test_helper"

describe User do
  let(:user) { users(:west)}

  it "must be valid when name is present" do
    user.valid?.must_equal true
  end

  it "must not be valid when name is absent" do
    user.name = nil
    user.valid?.must_equal false
    user.errors.must_include :name
  end

end
