require "test_helper"

describe User do
  let(:user) { User.new }

  describe "validations" do
      it "can be created with all fields" do
        u = User.new(name: "lainie")
        u.must_be :valid?
      end

      it "requires a name" do
        u = User.new
        is_valid = u.valid?
        is_valid.must_equal false
        u.errors.messages.must_include :name
      end
    end


  describe "relations" do

    it "has a collection of votes" do
      u = User.create!(name: "steph")
      u.must_respond_to :vote
      u.vote.must_be :empty?
      w = Work.create(title: "whatever", category: "Movie")
      v = Vote.create!(user_id: u.id, work_id: w.id)
      u.vote  << v
      u.vote.must_include v
    end
  end
end
