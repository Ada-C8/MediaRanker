require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  describe "validations" do
    it "responds to and accesses user_id and work_id" do
      vote.must_respond_to :user_id
      vote.user_id.must_equal :user_id
      vote.must_respond_to :work_id
      vote.work_id.must_equal :work_id
    end

    it "requires a user_id and work_id to be valid" do
    end

    it "requires the same user_id and work_id cannot be associated in more than 1 vote instance" do
    end
  end

  describe "relations" do

  end

  describe "custom methods" do
  end

end
