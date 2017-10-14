require "test_helper"

describe Work do

  let(:work) { Work.new }
  let(:w) { Work.new(category: "album", title: "Infinite Worlds", creator: "Vagabon", publication_year: 2017, description: "On her compact debut, Lætitia Tamko explores ideas of home, community, and sharing space with others who don’t necessarily see eye to eye.") }

  describe "validations" do

    it "can be created with all fields" do
      w.must_be :valid?
    end

    it "is invalid without a category" do
      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :category
    end

    it "is invalid without a title" do
      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :title
    end

    it "is invalid without a creator" do
      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :creator
    end
  end

  describe "relations" do
    it "responds to votes" do
      work.must_respond_to :votes
    end
  end

  describe "top_ten method" do
    it "returns an Array of Work objects" do
      Work.top_ten.must_be_instance_of Array

      Work.top_ten[0].must_be_instance_of Work
    end

    #TODO: check that object at first index has more votes than object at second index and last index
  end

  describe "top_work method" do
    it "returns a Work object" do
      Work.top_work.must_be_instance_of Work
    end
  end

  describe "albums_sorted_by_votes method" do
    it "returns an Array of work objects whose category is 'albums'" do
      Work.albums_sorted_by_votes.must_be_instance_of Array
      Work.albums_sorted_by_votes[0].must_be_instance_of Work
      Work.albums_sorted_by_votes[0].category.must_equal "album"
    end
  end

  describe "books_sorted_by_votes method" do
    it "returns an Array of work objects whose category is 'books'" do
      Work.books_sorted_by_votes.must_be_instance_of Array
      Work.books_sorted_by_votes[0].must_be_instance_of Work
      Work.books_sorted_by_votes[0].category.must_equal "book"
    end
  end

  describe "movies_sorted_by_votes method" do
    it "returns an Array of work objects whose category is 'movies'" do
      Work.movies_sorted_by_votes.must_be_instance_of Array
      Work.movies_sorted_by_votes[0].must_be_instance_of Work
      Work.movies_sorted_by_votes[0].category.must_equal "movie"
    end
  end

  # describe "work_sorted_by_votes method" do
  #   it "returns an Array of Work objects" do
  #     work_category = "album"
  #     Work.work_sorted_by_votes(work_category).must_be_instance_of Array
  #
  #     Work.work_sorted_by_votes(work_category)[0].must_be_instance_of Work
  #   end
  # end

  #Don't need this test as it is in a private method
  # describe "sort_by_most_votes method" do
  #
  #   it "returns an Array of Work objects" do
  #     Work.sort_by_most_votes.must_be_instance_of Array
  #
  #     Work.sort_by_most_votes[0].must_be_instance_of Work
  #   end
  #
  #   it "is sorted in descending order" do
  #     sorted_works = Work.sort_by_most_votes
  #     index_1 = sorted_works[0].votes
  #     index_2 = sorted_works[1].votes
  #
  #     index_1.must_be :>, index_2
  #   end
  # end

end
