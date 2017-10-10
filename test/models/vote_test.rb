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



  end

  # describe "custom methods" do
  #
  # end
end
