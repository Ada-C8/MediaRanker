require "test_helper"
require 'pry'

describe Work do
  describe 'validations' do
    let(:work) { Work.new }

    it "is invalid without a title" do
      result = work.valid?
      result.must_equal false

      work.errors.messages.must_include :title
    end

    it "is valid with a title" do
      movie = works(:movie_one)
      movie.title = nil
      (movie.valid?).must_equal false

      movie.title = "New Movie Title"
      (movie.valid?).must_equal true

    end

    it "is invalid with a title shared by another work in the same category" do
      existing_book = works(:book_one)
      new_book_same_title = Work.new(category: existing_book.category, title: existing_book.title)

      new_book_same_title.valid?.must_equal false

      new_book_same_title.errors.must_include :title
    end

    it "is valid if it shares the same title of a Work in a different category" do
      book_with_title = works(:book_one)
      album_with_same_title = Work.new(category: "album", title: book_with_title.title)

      album_with_same_title.valid?.must_equal true
    end

    #TODO: Test Relations to Votes

  end

  describe "self.sorted_by_votes method" do
    it "returns an array sorted by ascend" do
      sorted_movies = ((Work.all).sorted_by_votes("movie"))
      sorted_albums = ((Work.all).sorted_by_votes("album"))
      sorted_books = ((Work.all).sorted_by_votes("book"))

      sorted_movies.each do |movie|
        movie.category.must_equal "movie"
      end
      sorted_albums.each do |album|
        album.category.must_equal "album"
      end
      sorted_books.each do |book|
        book.category.must_equal "book"
      end

      [sorted_movies, sorted_albums, sorted_books].each do |works|
        ((works[0]).votes.count).must_be :>=, ((works[-1]).votes.count)
      end

    end
  end

  it "can have votes" do
    movie = works(:movie_one)
    user = users(:user_two)
    @vote = Vote.new
    @vote.work = movie
    @vote.user = user
    @vote.save

    ((movie.votes).last).id.must_equal @vote.id
  end

end
