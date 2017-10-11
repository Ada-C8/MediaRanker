require "test_helper"

describe Vote do
  describe "validations" do
    let(:user) { User.create!(username: "test")}
    let(:work) { Work.create!(title: "test", category: "test")}
    it "must be valid, created with all fields" do
      v = Vote.new(work_id: work, user_id: user)
      v.must_be :valid?
    end
    it "isn't valid with out user_id" do
      v = Vote.new
      v.wont_be :valid?
      v.errors.messages.must_include :user_id
    end
    it "isn't valid with out work_id" do
      v = Vote.new
      v.wont_be :valid?
      v.errors.messages.must_include :work_id
    end
  end

  describe "relations" do
    it "responds to user" do
      v = Vote.new(work_id: work.work_is, user_id: user.user_id)
      v.must_respond_to :user
    end

    it "responds to work" do
      v = Vote.new(work_id: work, user_id: user)
      v.must_respond_to :work
    end
  end

  describe "methods" do
  end
end
