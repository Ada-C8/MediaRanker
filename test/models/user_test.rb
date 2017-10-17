require "test_helper"

describe User do
  let(:user) { User.new }
  let(:gale) { users(:gale) }

  it "must have a username to be valid" do
    gale.valid?.must_equal true

    gale.username = nil
    gale.valid?.must_equal false
  end
  it "must have a unique username to be valid" do
    copycat = User.new(username: "galestorm")
    copycat.valid?.must_equal false
  end
  it "has a collection of associated votes" do
    my_votes = Vote.where(user_id: gale.id)

    my_votes.length.must_equal 3
    my_votes[0].must_be_instance_of Vote
  end
end
