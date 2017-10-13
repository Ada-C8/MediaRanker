require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:book) {works(:hp)}

  it "empty parameters are invalid" do
    work.valid?.must_equal false
  end
  it "empty title is invalid" do
    book.title = nil
    book.valid?.must_equal false
    book.title = ""
    book.valid?.must_equal false
  end
  it "empty category is invalid" do
    book.category = nil
    book.valid?.must_equal false
  end
  it "empty creator is invalid" do
    book.creator = nil
    book.valid?.must_equal false
  end
  it "empty publication_year is invalid" do
    book.publication_year = nil
    book.valid?.must_equal false
  end
  it "needs all parameteres to be valid" do
    book.valid?.must_equal true
  end
  it "the name must be unique for category" do
    book2 = Work.new(title:book.title,category:book.category,publication_year:1999,creator:"jk")
    book2.save
    book2.valid?.must_equal false
  end
  it "the name can be same for different category" do
    book2 = Work.new(title:book.title,category:"movie",publication_year:1999,creator:"jk")
    book2.save
    book2.valid?.must_equal true
  end

  it "has relations" do
    book.upvotes[0].id.must_equal upvotes(:two).id
  end
end
