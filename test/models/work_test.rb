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

  end

  describe 'creating a new Work' do
    it "requires only a title to create a new Work" do
      work = Work.new

      work.valid?.must_equal false

      work.title = "New Work"

      work.valid?.must_equal true
    end

    it "raises an error if there is a Work that has the same category AND same title" do
      existing_book = works(:book_one)
      new_book_same_title = Work.new(category: existing_book.category, title: existing_book.title)

      new_book_same_title.valid?.must_equal false

      new_book_same_title.errors.must_include :title
    end

    it "allows you to create a new Work that has the same title of a Work in a different category" do
      book_with_title = works(:book_one)
      album_with_same_title = Work.new(category: "album", title: book_with_title.title)

      album_with_same_title.valid?.must_equal true
    end
  end

end
