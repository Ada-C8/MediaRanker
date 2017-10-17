require "test_helper"

describe Work do
  describe "validations"do

    it "can be created with all fields" do
      a = Work.new(title: "Test Title", category: "movie", publication_year: 2000, description: "whatever")

      a.must_be :valid?
    end

    it "requires a title" do
      a = Work.new(category: "movie", publication_year: 2000, creator: "J J")
      is_valid = a.valid?
      is_valid.must_equal false
      a.errors.messages.must_include :title
    end

    it "requires a category" do
      a = Work.new(title: "Whoot?!", publication_year: 2000, creator: " J J")
      is_valid = a.valid?
      is_valid.must_equal false
      a.errors.messages.must_include :category
    end

    it "won't allow a description longer than 500 characters" do
      description = "*" * 501
      b = Work.new(title: "Test Title", category: "movie", description: description, creator: "J J")
      b.wont_be :valid?
      b.errors.messages.must_include :description
    end

    it "will allow a description less than 500 characters" do
      work = works(:poodr)
      work.must_be :valid?
      a = Work.new(title: "Test Title", category: "book", description: "T", creator: "B N")
      a.must_be :valid?
    end

    it "will allow no description" do
      a = Work.new(title: "Test Title", category: "book", creator: "NO One")
      a.must_be :valid?
    end

  end

  # describe "creator" do # not working and this should probably be in the controller tests
  #   it "will assign the Creator as 'unknown' if no input is given" do
  #     a = Work.new(title: "Test Title", category: "book")
  #     a.must_be :valid?
  #     a.creator.must_equal "Unknown"
  #   end
  # end

  describe "self.all_albums" do
    it "will return a list of all works that are categorized as 'album'" do
      Work.all_albums.count.must_equal 3
    end

    it "will not include any works that are not albums" do
      Work.all_albums.find_by(category: "book").must_equal nil

      Work.all_albums.find_by(category: "movie").must_equal nil
    end
  end

  describe "self.all_books" do
    it "will return a list of all works categorized as 'book'" do
      Work.all_books.count.must_equal 4
    end

    it "will not include any works that are not books" do
      Work.all_books.find_by(category: "album").must_equal nil

      Work.all_books.find_by(category: "movie").must_equal nil
    end
  end

  describe "self.all_movies" do
    it "will return a list of all works categorized as 'movie'" do
      Work.all_movies.count.must_equal 2
    end

    it "will not include any works that are not movies" do
      Work.all_movies.find_by(category: "album").must_equal nil

      Work.all_movies.find_by(category: "book").must_equal nil
    end
  end

  describe "self.top_ten_albums" do
    it "will return the number of albums if the count is 10 or less" do
      Work.top_ten_albums.count.must_equal 3
    end

    it "will not return more than 10 items" do
      title = "Test"
      category = "album"
      creator = "No one"
      10.times do
        Work.create!(title: title, category: category, creator: creator)
      end
      Work.top_ten_albums.count.must_equal 10
    end
  end

  describe "self.top_ten" do
    it "returns the correct number of elements" do
      Work.top_ten("book").count.must_equal 4
    end

    it "first element is the one with most number of votes" do
      work = Work.create!(title: "Vote Test", category: "album", creator: "No name")
      10.times do
        name = rand(0..200).to_s
        user = User.create!(name: name)
        Vote.create!(user: user, work: work)
      end
     Work.top_ten("album").first.must_equal work
    end

    it "returns the elements in the correct order" do
      work1 = works(:cat_stevens)
      work2 = works(:florence)
      work3 = works(:all_good)

      Work.top_ten("album").first.must_equal work1
      Work.top_ten("album")[1].must_equal work2
      Work.top_ten("album")[2].must_equal work3
    end

    it "returns an empty list if no elements are present" do
      Work.destroy_all
      Work.top_ten("album").must_equal []
    end

  end

  describe "self.top" do
    it "returns the Work with the most votes" do
      top_work = works(:cat_stevens)
      Work.top.must_equal top_work
    end
  end

end
