require "test_helper"

describe User do
  let(:u) { User.new(name: "Mira") }
  let(:v) { Vote.new(user_id: u.id, date: Date.today) }

describe "Relationships" do
  it "has many votes" do
    u.must_respond_to :votes
    u.votes.must_be_empty

    u.votes << v
    u.votes.must_include v
  end # it "has many votes" do
end # describe "Relationships" do

describe "Validations" do
  it "can be created with all fields" do
    u = User.new(name: "Marc")
    u.must_be :valid?
  end # it "can be created with all fields" do

  it "requires a name" do
    u2 = User.new
    u2.wont_be :valid?
  end

  it "strips white space from the beginning and end of a name" do
    u = User.new(name: " Marc ")
    u.name.length.must_equal 4     
  end # uniqueness
end # describe "Validations" do

end # User do
