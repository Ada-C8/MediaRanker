require "test_helper"

describe Vote do
  it "has a user associated" do
    votes(:one).user.must_equal users(:jake)
  end

  it "has a work associated" do
    votes(:one).work.must_equal works(:book)
  end

end
