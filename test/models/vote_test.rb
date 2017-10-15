require "test_helper"

describe Vote do

  describe "validations" do
    # success validation case for the working model
    it "can be created with all required fields" do
      vote = Vote.new(date: Date.today, user: users(:user1), work: works(:book8))
      vote.must_be :valid?
    end

    # failure validation cases
    it "requires a date" do
      v = Vote.new(user: users(:user1), work: works(:book8))
      v.wont_be :valid?
      v.errors.messages.must_include :date
    end

    it "cannot have two votes for the same work from one user" do
      works(:book8).votes.count.must_equal 0
      v1 = Vote.new(date: Date.today, user: users(:user8), work: works(:book8))
      v1.save
      works(:book8).votes.count.must_equal 1
      v2 = Vote.new(date: Date.today, user: users(:user8), work: works(:book8))
      v2.save
      v2.errors.messages.values.must_include ["has already voted for this work."]

      works(:book8).votes.count.must_equal 1
    end

    it "can have two votes for the same work from different users" do
      works(:book8).votes.count.must_equal 0
      v1 = Vote.new(date: Date.today, user: users(:user8), work: works(:book8))
      v1.save
      works(:book8).votes.count.must_equal 1
      v2 = Vote.new(date: Date.today, user: users(:user9), work: works(:book8))
      v2.save
      v2.errors.messages.values.wont_include ["has already voted for this work."]

      works(:book8).votes.count.must_equal 2
    end
  end

  describe "relations" do

    it "belongs to a user and creates an error message if no user is given" do
      v = Vote.new(date: Date.today, work: works(:book8))
      v.must_respond_to :user
      v.wont_be :valid?
      v.errors.messages.must_include :user
    end

    it "belongs to a work and creates an error message if no work is given" do
      v = Vote.new(date: Date.today, user: users(:user1))
      v.must_respond_to :work
      v.wont_be :valid?
      v.errors.messages.must_include :work
    end

  end

end
