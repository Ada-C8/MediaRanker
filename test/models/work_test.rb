require "test_helper"

describe Work do
  describe "valiations" do
    it "is valid" do
      w = Work.new(title: "Kick Jump Twist")
      w.must_be :valid?
    end

    it "isn't valid if no title, or empty string" do
      w = Work.new
      w.wont_be :valid?

      w.title = ""
      w.wont_be :valid?
      w.errors.messages.must_include :title
    end
  end

  describe "relationships" do
    it "can have a vote" do
      w = Work.new(title: "Kick Jump Twist")
      w.must_respond_to :votes
    end

  end

  describe "sort_by_category" do
    let :books {Work.sort_by_category("book")}

    it "returns an array of works with the right category" do
      books.must_be_kind_of Array
      book_test = books.sample
      book_test.must_be_kind_of Work
      book_test.category.must_equal "book"
    end

    it "is sorted so the first has more votes than last" do
      first = books.first.votes.count
      last = books.last.votes.count
      first.must_be_greater_than_or_equal_to last
    end

    it "returns an empty array if there are no things to fit that category" do

    end
  end

  describe "popular" do

  end

  describe "most_popular " do

  end

  describe "top_10" do

  end
end
