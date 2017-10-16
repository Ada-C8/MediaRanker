require "test_helper"

describe Vote do
  let :user {User.first}
  let :work {Work.first}
  describe "validations" do
    it "can be created with all fields" do
      v = Vote.new(user: user , work: work)
      v.must_be :valid?
    end

    it "requieres an user" do
      v = Vote.new
      is_valid = v.valid?
      is_valid.must_equal false
      v.errors.messages.must_include :user
    end

    it "requieres a work" do
      v = Vote.new
      is_valid = v.valid?
      is_valid.must_equal false
      v.errors.messages.must_include :work
      #como funciona esto?
    end
  end
end
