require "test_helper"

describe User do
  let(:user) { User.new }
  let(:user1) { users(:user1) }

  describe 'relationships' do
    it "can have votes" do
      user1.votes.length.must_equal 1
    end
  end #Relationships
end
