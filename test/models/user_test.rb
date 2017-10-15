require "test_helper"

describe User do
  let :user { User.new }

  describe "validations" do
    it "can be created with all valid fields" do
      before_count = User.count
      user.wont_be :valid?
      user[:name] = "Test First User Name"

      user.save!
      user.must_be :valid?
      user.name.must_equal "Test First User Name"
      User.count.must_equal before_count + 1
    end

    it "should be invalid if username is has no entry" do
      before_count = User.count
      user.save

      user.wont_be :valid?
      user.errors.messages.must_include :name
      User.count.must_equal before_count
    end

    it "has a username" do
      users(:one).name.must_equal "Owly"
    end

    it "can be created if there are no previous users" do
      User.destroy_all

      User.count.must_equal 0

      user[:name] = "New User"
      user.must_be :valid?
      user.save!

      User.count.must_equal 1
      user.errors.messages.wont_include :name
    end
  end # Describe

  describe "uniqueness" do
    it "must raise on error and cannot be saved if the username already exists" do
      before_count = User.count
      user[:name] = "Owly"
      user.save

      user.wont_be :valid?
      user.errors.messages.must_include :name
      User.count.must_equal before_count
    end
  end

  describe "relations" do
    it "must respond to votes" do
      user = users(:one)
      work = works(:book)
      before_vote_count = user.votes.count

      new_vote = Vote.create!(user_id: user.id, work_id: work.id)

      user.must_respond_to :votes
      user.votes.must_include new_vote
      user.votes.count.must_equal before_vote_count + 1
    end
  end

end # Describe
