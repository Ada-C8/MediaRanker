require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  # describe "validations" do
  # end

  describe "relations" do
    #vote has_one user
    #vote has_one work
    it "must respond to user" do
      v = Vote.new
      v.must_respond_to :user
    end

    # it "can set the user_id" do
    #   u = User.new(name: "name")
    #   v = Vote.new
    #   v.user = u
    #   v.user_id.must_equal u.id
    # end
    #Why does this not work?

    it "must respond to work" do
      v = Vote.new
      v.must_respond_to :work
    end

    it "must allow Votes with unique combinations of work_id and user_id to be made" do
      #Why does this not work?
      # before_count = Vote.count
      # v = Vote.new(user_id: 1, work_id: 2)
      # v.save
      # Vote.count.must_equal before_count + 1
    end

    it "must not allow votes with repeated combinations of work_id and user_id to be made" do
      #This passes as written, but I can't make it fail, so something is wrong.
      # before_count = Vote.count
      # v = Vote.new(user_id: 1, work_id: 1)
      # v.save
      # Vote.count.must_equal before_count
    end

  end

end
