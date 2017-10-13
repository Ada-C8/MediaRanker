require "test_helper"

describe Work do
  let(:w) { Work.first }
  let(:u) { User.new(name: "Mira") }
  let(:v) { Vote.new(user_id: u.id) }

  it "has many votes" do
    w.must_respond_to :votes
    # starts off without any votes
    w.votes.must_be_empty

    # Can add a vote to it
    w.votes << v
    w.votes.must_include v
  end # it "has many votes" do

  it "requires a title" do
    w2 = Work.new
    is_valid = w2.valid?
    is_valid.must_equal false
    w2.errors.messages.must_include :title
  end # it "requires a title" do

  it "will create an instance of Work when all fields are present" do
      w3 = Work.new(category: "Book", title: "Harry Potter and the Prisoner of Azkaban", creator: "J.K. Rowling", publication_year: 2001, description: "The third Harry Potter book")

      w3.must_be :valid?
  end # it "will create an instance of Work when all fields are present" do

  it "requires a category" do
    w2 = Work.new
    is_valid = w2.valid?
    is_valid.must_equal false
    w2.errors.messages.must_include :category
  end
end
