require "test_helper"

describe User do
  let(:user) { User.new }
  let(:user1) { users(:user1) }

  describe 'relationships' do
    it "can have votes" do
      user1.votes.length.must_equal 1
    end
  end #Relationships

  describe "validations" do
    it "must have a username to be valid" do
      #false
      user.valid?.must_equal false
      user.errors[:username].must_include "can't be blank"

      #true
      user.username = "A Name"
      user.valid?.must_equal true
    end

    it "must have a unique username to be valid" do
      # false
      user.username = user1.username
      user.valid?.must_equal false

      #true
      user.username = "#{user1.username} Changed"
      user.valid?.must_equal true
    end

  end # validations set

end
