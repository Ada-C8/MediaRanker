require "test_helper"

describe Vote do
  let(:w) { Work.first }
  let(:u) { User.new(name: "Mira") }
  let(:v) { Vote.new(user_id: u.id, date: Date.today) }

  describe "relationships" do
    it "belongs to a user" do
      v.user = u
      v.must_respond_to :user
      v.user.must_equal u
      v.user_id.must_equal u.id
    end # it "belings to a user" do

    it "belongs to a work" do
      v.must_respond_to :work
      v.work = w
      v.work.must_equal w
      v.work_id.must_equal w.id
    end # it "belongs to a work" do
  end # describe "relationships" do

  describe "validations" do
    it "can be created with all fields" do
      # TODO: is it ok that I have to save u to make this test pass?
      u.save
      v = Vote.new(user_id: u.id, work_id: w.id, date: Date.today)
      v.must_be :valid?
    end # it "can be created with all fields" do
  end # describe "validations" do
end # Vote do
