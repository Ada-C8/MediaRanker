require "test_helper"

describe Work do

  describe "validations" do
    # success validation case for the working model
    it "can be created with all required fields" do
      work = Work.new(:category => "album", :title => "Liquid Spirit")
      work.must_be :valid?
    end

    # failure validation cases
    it "requires a title" do
      w = Work.new
      w.wont_be :valid?
      w.errors.messages.must_include :title
    end

    it "requires a category" do
      w = Work.new
      w.wont_be :valid?
      w.errors.messages.must_include :category
    end
  end

  describe "relations" do
    it "responds to votes and can be voted on once" do
      # arrange
      w = works(:book9)
      w.must_respond_to :votes
      w.votes.must_be :empty?
      w.votes.count.must_equal 0
      vote = Vote.create!(date: Date.today, work_id: w.id, user_id: users(:user1).id)

      # act
      w.votes << vote

      #assert
      w.votes.count.must_equal 1
      w.votes.must_include vote
    end

    it "can have multiple votes" do
      # arrange
      w = works(:book9)
      w.votes.must_be :empty?
      w.votes.count.must_equal 0

      vote1 = Vote.create!(date: Date.today, work_id: w.id, user_id: users(:user1).id)
      w.votes << vote1

      vote2 = Vote.create!(date: Date.today, work_id: w.id, user_id: users(:user2).id)

      # act
      w.votes << vote2

      #assert
      w.votes.count.must_equal 2
      w.votes.must_include vote1
      w.votes.must_include vote2
    end

    # Test dependent destroy relationship
    it "can destroy dependent relationship to vote" do
      # arrange
      w = works(:lemonade)

      vote1 = Vote.create!(date: Date.today, work_id: w.id, user_id: users(:user1).id)
      w.votes << vote1

      vote2 = Vote.create!(date: Date.today, work_id: w.id, user_id: users(:user2).id)
      w.votes << vote2

      # act
      w.destroy!

      #assert
      Vote.all.wont_include vote1
      Vote.all.wont_include vote2
      w.votes.count.must_equal 0
    end
  end

  describe "custom public methods" do
    describe "top_work" do
    it "returns top voted work" do
      # top voted work in fixtures is Hunger
      w = works(:Hunger)
      Work.top_work.must_equal w
    end
  end

  describe "top_ten" do
    it "returns the top ten media in a category that has more than 10 items" do
      # top voted books in fixtures are Hunger, book3, Kindred, and book4 in that order the rest of the books have zero votes
      top_books = Work.top_ten("book")

      top_books.count.must_equal 10

      top_books.first(4).must_equal [works(:Hunger), works(:book3), works(:Kindred), works(:book4)]
    end

    it "returns all media in a category that has fewer than 10 items" do
      # there are only two albums and they are Lemonade and Liquid Spirit in that order by votes
      top_albums = Work.top_ten("album")

      top_albums.count.must_equal 2

      top_albums.must_equal [works(:lemonade), works(:LiquidSpirit)]
    end

    it "returns an empty array if category has no works" do
      top_albums = Work.top_ten("movie")
      top_albums.must_be :empty?
    end
  end
end

end
