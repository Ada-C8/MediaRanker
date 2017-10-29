require "test_helper"

describe User do
  describe "validations" do
  let(:user) { User.new }

  it "must be valid with correct validations" do
    users(:one).must_be :valid?
  end



  it "must only accept a user with email formatting" do
    g = User.new(name: "Joe", email: "an email")
    start_count = User.all.length
    g.wont_be :valid?
    g[:email] = "joeschmoe@somemail.com"
    g.must_be :valid?
    g.save
    start_count.must_equal User.all.length - 1
  end


end

  describe "validations" do

  end
end
