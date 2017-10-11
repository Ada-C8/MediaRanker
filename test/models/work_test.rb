require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:book) { works(:book) }

  it "must have a title" do
    #book currently has title, should return true
    book.valid?.must_equal true

    book.category = nil
    book.title = nil
    book.save

    book.errors.keys.must_include :title
    book.errors.keys.must_include :category

  end
end
