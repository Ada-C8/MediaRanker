require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:book) { works(:book1)}

  describe "validations" do
    it "must have a title to be valid" do
      #false
      work.category = "album"
      work.valid?.must_equal false
      work.errors[:title].must_include "can't be blank"

      #true
      work.title = "A Title"
      work.valid?.must_equal true
    end

    it "must have a category to be valid" do
      #false
      work.title = "A Title"
      work.valid?.must_equal false
      work.errors[:category].must_include "can't be blank"

      #true
      work.category = "album"
      work.valid?.must_equal true
    end

    it "must have a unique title in relation to its category to be valid" do
      # false
      new_book = Work.new(title: book.title, category: book.category)
      another_book = Work.new(title: book.title, category: book.category)

      (new_book && another_book).valid?.must_equal false

      #true
      new_book.title = "#{book.title} Changed"
      new_book.valid?.must_equal true

      another_book.category = "album"
      another_book.valid?.must_equal true
    end

  end # validations set
end
