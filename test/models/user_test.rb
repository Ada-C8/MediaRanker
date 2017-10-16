require "test_helper"

describe User do
  let(:user) { User.new }
  let(:crisco) { users(:crisco) }

  it "must be valid if it has a name" do
    crisco.valid?.must_equal true
    crisco.name = nil
    crisco.valid?.must_equal false
  end

  it "should not be valid if user with that name already exists" do
    user.name = crisco.name
    user.save.must_equal false
    user.errors.keys.must_include :name
    user.errors[:name].must_equal ["has already been taken"]
  end
end
