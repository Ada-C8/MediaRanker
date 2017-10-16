require "test_helper"

describe Vote do
  before do
    @vote = Vote.new
  end

  describe "validations" do
    it "can created with all fields" do
      v = Vote.new(user_id: User.first.id, work_id: Work.first.id)

      v.must_be :valid?
    end

    it "is invalid without a user_id" do
      result = @vote.valid?
      result.must_equal false
      @vote.errors.messages.must_include :user_id
    end

    it "is invalid without a work_id" do
      result = @vote.valid?
      result.must_equal false
      @vote.errors.messages.must_include :work_id
    end

    it "is invalid when the user_id and work_id pairing is not unique" do
      work = Work.create!(category: "album", title: "title", creator: "creator")
      user = User.create!(name: "name")
      vote1 = Vote.new(user_id: work.id, work_id: user.id)
      vote1.save
      vote2 = Vote.new(user_id: work.id, work_id: user.id)

      vote2.wont_be :valid?
    end
  end

  describe "relations" do
    it "responds to work" do
      @vote.must_respond_to :work
    end

    it "responds to user" do
      @vote.must_respond_to :user
    end
  end
end
