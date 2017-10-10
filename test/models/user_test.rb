require "test_helper"

# describe User do
#   let(:user) { User.new }
#
#   it "must be valid" do
#     value(user).must_be :valid?
#   end
# end

describe "validations" do
  it "requires a username" do
    u = User.new
    u.wont_be :valid?
    u.errors.messages.must_include :name
  end

  it "accepts username only <= 10 characters" do
    u = User.new(name: "Neo")
    u.must_be :valid?
  end

  it "not accepts username > 10 characters" do
    u = User.new(name: "Reallylongname")
    u.wont_be :valid?
    u.errors.messages.must_include :name
  end
end
