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

    it "must respond to work" do
      v = Vote.new
      v.must_respond_to :work
    end



  end

  # describe "custom methods" do
  #
  # end
end
