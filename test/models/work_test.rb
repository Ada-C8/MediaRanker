require "test_helper"

describe Work do
  let(:w) { Work.first }
  let(:u) { User.new(name: "Mira") }
  let(:v) { Vote.new(user_id: u.id) }
  let(:w3) {Work.new(category: "Book", title: "Harry Potter and the Prisoner of Azkaban", creator: "J.K. Rowling", publication_year: 2001, description: "The third Harry Potter book")}
  let(:w4) {Work.new(category: "Movie", title: "Singing in the rain", creator: "Gene Kelly", publication_year: 2001, description: "Amazing musical")}


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
      w3.must_be :valid?
  end # it "will create an instance of Work when all fields are present" do

  it "requires a category" do
    w2 = Work.new
    is_valid = w2.valid?
    is_valid.must_equal false
    w2.errors.messages.must_include :category
  end

  describe "methods" do
    describe "sort_by_vote_count" do
      it "will sort the works by vote count in decending order" do
        #TODO: figure out why this test isn't passing!
        # Arrange
          # create a second work to vote on
          w3.save
          w.save
          # create a second user to vote
            u2 = User.last

        # Act (vote on the two works, w and w3)
          w.votes.create(user_id: u.id, work_id: w.id)
          w3.votes.create(user_id: u2.id, work_id: w3.id)
          w3.votes.create(user_id: u.id, work_id: w3.id)
          sorted = Work.sort_by_vote_count

        # Assert
          sorted.first.id.must_equal w3.id
      end # it will sort by vote_count
    end # sort_by_vote_count

    describe "top_work" do
      it "will return the top rated work" do
        w3.save
        w4.save
        u2 = User.last

        w3.votes.create(user_id: u.id, work_id: w3.id)
        w3.votes.create(user_id: u2.id, work_id: w3.id)
        w4.votes.create(user_id: u.id, work_id: w4.id)
        top = Work.top_work

        top.must_equal w3.title
      end # return the top work
    end # top_work

    it "will return the top ten works of a category" do
      ten = Work.top_ten("album")

      length = ten.length
      i = 0
      while i < length
        work.votes[i].must_be :>=, work.votes[i - 1].votes
      end

      ten.first.category.must_equal "album"
    end # return the top ten works for a category

  end # methods
end
