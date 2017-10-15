require "test_helper"

describe User do

  it "must be valid" do
    users(:user_one).must_be :valid?
  end
end
