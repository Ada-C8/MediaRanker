require "test_helper"

describe Category do
  let(:book) { categories(:book) }
  let(:album) { categories(:album) }

  describe "validations" do
    it "must have a name" do
      book.name = nil
      book.valid?.must_equal false

      book.name = "book"
      book.valid?.must_equal true
    end

    it "must have a unique name" do
      album_cat = album.name
      new_cat = Category.new(name: album_cat)
      new_cat.valid?.must_equal false

      new_cat.name = "Unique name"
      new_cat.valid?.must_equal true
    end
  end

  describe "relations" do
    it "must cascade delete associated works" do
      an_album = works(:nonsense)
      num_works = Work.count

      album.destroy

      Work.count.must_equal (num_works - 1)
      Work.all.wont_include an_album
    end
  end
end
