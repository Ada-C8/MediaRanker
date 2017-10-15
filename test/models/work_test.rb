require "test_helper"

describe Work do
  describe 'validations' do
    let(:work) { Work.new }

    # it "must be valid" do
    #   value(work).must_be :valid?
    # end

    it "is invalid without a title" do
      result = work.valid?
      result.must_equal false

      work.errors.messages.must_include :title
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

  describe "self.top_ten method" do
    it "returns a max of ten works per category" do
      ((Work.all).top_ten("movie").count).must_be :<=, 10
      ((Work.all).top_ten("album").count).must_be :<=, 10
      ((Work.all).top_ten("book").count).must_be :<=, 10 
    end
  end

end
