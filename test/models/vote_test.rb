require "test_helper"

describe Vote do
  let :user { User.first }
  let :work { Work.first }
  let :vote { Vote.new(work: work, user: user) }

  describe "valiations" do
    it "is a valid vote" do
      vote.must_be :valid?
    end

    it "requires a user_id" do
      b = Vote.new
      b.wont_be :valid?
      b.errors.messages.must_include :user_id
    end

    it "requires a work_id" do
      b = Vote.new
      b.wont_be :valid?
      b.errors.messages.must_include :work_id
    end
  end

  describe "relationships" do
    it "is connected to a work" do
      vote.must_respond_to :work
    end

    it "is connected to a user" do
      vote.must_respond_to :user
      vote.user.must_equal user
      vote.user_id.must_equal user.id
    end
  end
end
