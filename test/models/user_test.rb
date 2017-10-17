require "test_helper"

describe User do
  let(:user) { User.new }
  let(:bob) { users(:bob) }
  let(:susie) { users(:susie) }

  it "must have a usename to be valid" do
    bob.valid?.must_equal true
    bob.username = ""
    bob.valid?.must_equal false
  end

end
