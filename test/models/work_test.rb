require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:gatsby) { works(:gatsby) }

  it "must have a category" do
    work.title = "Title"

    work.valid?.must_equal false
    work.category = "Category"
    work.valid?.must_equal true
  end

  it "must have a title" do
    work.category = "Category"

    work.valid?.must_equal false
    work.title = "Title"
    work.valid?.must_equal true
  end

  it "must have a unique title" do
    work.title = "The Great Gatsby"
    work.category = "Category"
    work.valid?.must_equal false
    work.title = "The Greater Gatsby"
    work.valid?.must_equal true
  end

  it "can have a vote" do
    gatsby.must_respond_to :votes
  end

  describe "front page methods" do
    let(:user1) { users(:user1) }
    let :work { Work.first }
    let :vote { Vote.new(work: work, user: user1) }

    it "sorts by popularity" do
      book = Work.top_ten("book")
      book.first.must_be_kind_of Work
      book.first.category.must_equal "book"
      book.first.title.must_equal "The Great Gatsby"
    end

    it "gets the top ten" do
      Work.top_ten("book").first.title.must_equal "The Great Gatsby"
    end

    it "gets the highest scoring work" do
      Work.spotlight.title.must_equal "The Great Gatsby"
    end
  end
end
