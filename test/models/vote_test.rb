require "test_helper"

describe Vote do
  describe "validations" do
    # it "requires a user id" do
    #   user_id = 1
    #   work_id = 1
    #   v = Vote.new(user_id, work_id)
    #   result = v.valid?
    #   result.must_equal true
    # end

    it "can be created with all fields" do
      u = User.create!
      w = Work.create!

      v = Vote.new(user_id: u, work_id: w)
      result = v.valid?
      result.must_equal true
    end

    # it "requires a work_id" do
    #   v = Vote.new(work_id: 1)
    #   result = v.valid?
    #   result.must_equal true
    # end
    #
    # it "requires a user id" do
    #   v = Vote.new
    #   result = v.valid?
    #   result.must_equal false
    # end
    #
    # it "requires a work_id" do
    #   v = Vote.new
    #   result = v.valid?
    #   result.must_equal false
    # end
  end

  # describe "relations" do
  #   it "must have user_id and work_id" do
  #     u = User.new(name: "bob")
  #     u.votes.count.must_equal 0
  #   end
  # end

end
