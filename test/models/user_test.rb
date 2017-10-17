require "test_helper"

describe User do
  let(:user) { User.new }

  it "must be valid" do
    user = (users(:one))
    user.must_be :valid?
  end

  describe "vote method" do
    it "Should create a vote" do
      num_votes = Vote.count

      user = users(:one)
      user.vote(works(:two))

      Vote.count.must_equal num_votes + 1
    end

    it "Should not create duplicate votes" do
      num_votes = Vote.count

      user = users(:one)
      user.vote(works(:two))
      user.vote(works(:two))

      Vote.count.must_equal num_votes + 1
    end
  end
end
