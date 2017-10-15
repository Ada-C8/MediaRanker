require "test_helper"

describe Work do
  let(:work) { Work.new }


  describe "validations" do
      it "can be created with all fields" do
        c = "Movie"
        w = Work.new(category: c, title: "test work")
        w.must_be :valid?
      end

      it "requires a title" do
        w = Work.new
        is_valid = w.valid?
        is_valid.must_equal false
        w.errors.messages.must_include :title
      end
    end


  describe "relations" do

    it "has a collection of votes" do
      w = Work.create!(category: "Book", title: "test work")
      w.must_respond_to :vote
      w.vote.must_be :empty?
      u = User.create!(name: "di")
      v = Vote.create!(user_id: u.id, work_id: w.id)
      w.vote  << v
      w.vote.must_include v
    end
  end


  describe "custom methods" do

    describe "self.sorted" do
      it "sorts all the works by vote number" do
        works = Work.sorted
        work_votes = works.first.vote.length + 1
        works.each do |work|
          work.vote.length.must_be :<=, work_votes
          votes = work.vote
        end
      end
    end

    describe "self.top" do
      it "returns the work with the most votes with no ties" do
        works = Work.all
        top = Work.top
        works.each do |work|
          work.vote.length.must_be :<=, top.vote.length
        end
      end
    end

    describe "self.top_ten_movies" do
      it "returns a list of up to ten movies that have the most votes with more than 0 movies" do
        works = Work.top_ten_movies
        movie_votes = works.first.vote.length + 1
        works.each do |work|
          work.category.must_equal "Movie"
          work.vote.length.must_be :<=, movie_votes
        end
        works.length.must_be :<=, 10
      end

      it "returns a list of up to ten movies that have the most votes with 0 movies" do
        Work.destroy_all
        works = Work.top_ten_movies
        puts ">>>>>>>>>>>>>>>WORKS: #{works}"
        movie_votes = works.first.vote.length + 1
        works.each do |work|
          work.category.must_equal "Movie"
          work.vote.length.must_be :<=, movie_votes
        end
        works.length.must_be :<=, 10
      end

    end

    describe "self.top_ten_books" do
      it "returns a list of up to ten books that have the most votes with more than 0 movies" do
        works = Work.top_ten_books
        book_votes = works.first.vote.length + 1
        works.each do |work|
          work.category.must_equal "Book"
          work.vote.length.must_be :<=, book_votes
        end
        works.length.must_be :<=, 10
      end

      #TEST FOR 0 BOOKS, TEST FOR 10 BOOKS, TEST FOR MORE THAN 10 BOOKS
    end

    describe "self.top_ten_music" do
      it "returns a list of up to ten books that have the most votes with more than 0 movies" do
        works = Work.top_ten_music
        music_votes = works.first.vote.length + 1
        works.each do |work|
          work.category.must_equal "Music"
          work.vote.length.must_be :<=, music_votes
        end
        works.length.must_be :<=, 10
      end
    end

  end #end of describe custom methods

end #end of describe work
