require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    users(:one).must_be :valid?
  end
end
