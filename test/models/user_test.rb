require "test_helper"

describe User do

  describe "validations" do
    # success validation case for the working model
    it "can be created with all required fields" do
      u = User.new(username: "test", date_joined: Date.today)
      u.must_be :valid?
    end

    # failure validation cases
    it "requires a username" do
      u = User.new(date_joined: Date.today)
      u.wont_be :valid?
      u.errors.messages.must_include :username
    end

    it "requires a date_joined" do
      u = User.new(username: "test")
      u.wont_be :valid?
      u.errors.messages.must_include :date_joined
    end
  end

  describe "relations" do
    it "responds to votes and user can vote on a work" do
      # arrange
      u = users(:user11)
      u.must_respond_to :votes
      u.votes.must_be :empty?
      u.votes.count.must_equal 0
      vote = Vote.create!(date: Date.today, work_id: works(:book8).id, user_id: u.id)

      # act
      u.votes << vote

      #assert
      u.votes.count.must_equal 1
      u.votes.must_include vote
    end

    it "can have multiple votes for different works" do
      # arrange
      u = users(:user11)
      u.votes.must_be :empty?
      u.votes.count.must_equal 0

      vote1 = Vote.create!(date: Date.today, work_id: works(:book8).id, user_id: u.id)
      u.votes << vote1

      vote2 = Vote.create!(date: Date.today, work_id: works(:book9).id, user_id: u.id)

      # act
      u.votes << vote2

      #assert
      u.votes.count.must_equal 2
      u.votes.must_include vote1
      u.votes.must_include vote2
    end

    # Test dependent destroy relationship
    it "can destroy votes when you destroy user" do
      # arrange
      u = users(:user11)

      vote1 = Vote.create!(date: Date.today, work_id: works(:book9).id, user_id: u.id)
      u.votes << vote1

      vote2 = Vote.create!(date: Date.today, work_id: works(:book8).id, user_id: u.id)
      u.votes << vote2

      # act
      u.destroy!

      #assert
      Vote.all.wont_include vote1
      Vote.all.wont_include vote2
      u.votes.count.must_equal 0
    end
  end


end
