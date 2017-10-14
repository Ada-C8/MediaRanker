require "test_helper"

describe User do
  let(:harry) { users(:harry) }

  describe "validations" do
    it "must be valid" do
      harry.valid?.must_equal true
    end

    it "must only allow unique usernames" do
      dup_user = User.new(name: users(:harry).name)
      dup_user.valid?.must_equal false

      dup_user.name = "New name"
      dup_user.valid?.must_equal true
    end

    it "must require username" do
      no_name = User.new(name: nil)
      no_name.valid?.must_equal false

      no_name = User.new(name: "")
      no_name.valid?.must_equal false
    end
  end

  describe "relations" do
    it "must cascade delete associated votes" do
      hermione_vote = votes(:two)
      num_votes = Vote.count

      votes(:two).destroy
      Vote.count.must_equal (num_votes - 1)
      Vote.all.wont_include hermione_vote
    end
  end

end
