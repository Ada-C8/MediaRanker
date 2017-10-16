require "test_helper"

describe Work do
  describe "Work" do
    let(:work) { Work.new }
    let(:book) { works(:book) }

    it "must have a title and a category" do
      #book currently has title, should return true
      book.valid?.must_equal true

      book.category = nil
      book.title = nil
      book.save

      book.errors.keys.must_include :title
      book.errors.keys.must_include :category
    end
  end
  describe "category return methods" do
    it "returns all of the albums" do
      @albums = Work.albums

      @albums.length.must_equal 3
      @albums.each do |album|
        album.category.must_equal "album"
      end
    end

    it "returns all of the movies" do
      @movies = Work.movies

      @movies.length.must_equal 2
      @movies.each do |movie|
        movie.category.must_equal "movie"
      end
    end

    it "returns all of the books" do
      @books = Work.books

      @books.length.must_equal 4
      @books.each do |book|
        book.category.must_equal "book"
      end
    end

    it "returns an array of categories available" do
      Work.categories.must_be_kind_of Array
      Work.categories.must_equal ["album", "book", "movie"]
    end
  end

  describe "other methods" do


    it "returns the selection of works in order from highest votes to lowest votes" do

    end
  end
end
