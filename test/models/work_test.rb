require "test_helper"

describe Work do
  let(:book) {works(:test_book)}

  it "requires a title to be valid" do
    book.valid?.must_equal true
    works(:titleless).valid?.must_equal false

    works(:titleless).title = "1984"
    works(:titleless).save
    works(:titleless).valid?.must_equal true
  end

  it "requires a category to be valid" do
    book.valid?.must_equal true
    works(:no_category).valid?.must_equal false

    works(:no_category).category = "book"
    works(:no_category).save
    works(:no_category).valid?.must_equal true
  end

  it "requires a creator to be valid" do
    book.valid?.must_equal true
    works(:no_creator).valid?.must_equal false

    works(:no_creator).creator = "George Orwell"
    works(:no_creator).save
    works(:no_creator).valid?.must_equal true
  end

  it "does not require a publication date to be valid" do
    book.valid?.must_equal true
    works(:no_pub_date).valid?.must_equal true
  end

  it "does not require a publication date to be valid" do
    book.valid?.must_equal true
    works(:no_description).valid?.must_equal true
  end

  it "requires a publication_year to be integers" do
    book = works(:no_pub_date)
    book.publication_year = "Two thousand and three"
    book.save
    book.valid?.must_equal false

    book.publication_year = 2003
    book.save
    book.valid?.must_equal true
  end


end
