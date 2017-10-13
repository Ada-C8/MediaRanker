require "test_helper"

describe Vote do
  let :work { works(:harrypotter) }
  let :user { users(:santa) }
  let :vote { Vote.new(work: work, user: user)}

  describe "valiations" do
    it "is a valid vote" do
      # need to login session!
      
      # b = Vote.new
      # b.user_id = 1
      # b.must_be :valid?

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
      vote.work.must_equal work
      vote.work_id.must_equal work.id
    end

    it "is connected to a user" do
      vote.must_respond_to :user
      vote.user.must_equal user
      vote.user_id.must_equal user.id
    end
  end
end
