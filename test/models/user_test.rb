require "test_helper"

describe User do
  let(:user) { User.new }
  let(:fanGirl) { users(:fanGirl) }
  let(:fanBoy) { users(:fanBoy) }

  it "must have a name" do
    fanGirl.valid?.must_equal true
    fanGirl.name = nil
    fanGirl.save
    fanGirl.valid?.must_equal false
    fanGirl.errors[:name].must_equal ["can't be blank"]
  end

  it "cannot create a new user with the same name" do
    new_user = User.new(name: "fanGirl")
    new_user.save
    new_user.valid?.must_equal false   
  end
end
