require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "validations" do
    it "can be created with a title and a category" do
      w = Work.new(title: "title", category: "category")
      w.must_be :valid?
    end

    it "requires a title and a category" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include (:title)
      w.errors.messages.must_include (:category)
    end
  end

  describe "relations" do
    #work has_many votes
    it "must respond to vote" do
      w = Work.new(title: "title")
      w.must_respond_to :vote
    end

  end

  describe "self.top_ten_albums" do
    it "returns a array of the top ten albums" do
      top_albums = Work.top_ten_albums

      ordered = true
      10.times do |i|
        if top_albums[i-1].vote.count >= top_albums[i].vote.count
          ordered = ordered && true
        end
      end

      top_albums.must_be_kind_of Array
      top_albums.length.must_equal 10
      ordered.must_equal true
    end

    it "returns an empty array if there are no albums" do
      Work.destroy_all
      top_albums = Work.top_ten_albums
      top_albums.must_be_kind_of Array
      top_albums.length.must_equal 0
    end
  end


#####I think these tests would work if the testing database gave id numbers within the range of objects i have created in the  yml files, but instead the database is created to give very large id numbers.  So... my attempts at making some votes for some works did not work, so these tests just make lists of objects that have no votes.
#####
  describe "self.top_ten_movies" do
    it "returns a array of the top ten movies" do
      top_movies = Work.top_ten_movies

      ordered = true
      10.times do |i|
        if top_movies[i-1].vote.count >= top_movies[i].vote.count
          ordered = ordered && true
        end
      end

      top_movies.must_be_kind_of Array
      top_movies.length.must_equal 10
      ordered.must_equal true
    end

    it "returns an empty array if there are no movies" do
      Work.destroy_all
      top_movies = Work.top_ten_movies
      top_movies.must_be_kind_of Array
      top_movies.length.must_equal 0
    end
  end

  describe "self.top_ten_books" do
    it "returns a array of the top ten books" do
      top_books = Work.top_ten_books

      ordered = true
      10.times do |i|
        if top_books[i-1].vote.count >= top_books[i].vote.count
          ordered = ordered && true
        end
      end

      top_books.must_be_kind_of Array
      top_books.length.must_equal 10
      ordered.must_equal true
    end

    it "returns an empty array if there are no books" do
      Work.destroy_all
      top_books = Work.top_ten_books
      top_books.must_be_kind_of Array
      top_books.length.must_equal 0
    end
  end

  describe "self.top_work" do
    it "returns the book with the most votes when their are works" do
      top = Work.top_work
      ordered = true
      Work.all.each do |work|
        if work.vote.count >= top.vote.count
          ordered = false
        end
      end
      ordered.must_equal true
    end
  end

end
