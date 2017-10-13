require "test_helper"

describe Work do
  # let(:work) { Work.new }
  #
  # it "must be valid" do
  #   value(work).must_be :valid?
  # end
  describe "validations" do
    it "can be created with all fields" do
      w = works(:awesome_movie)
      result = w.valid?
      result.must_equal true
    end

    it "must have a title" do
      w = works(:epic_album)
      result = w.valid?
      result.must_equal false
      w.errors.messages.must_include :title
    end

    it "must have a category" do
      w = works(:good_book)
      result = w.valid?
      result.must_equal false
      w.errors.messages.must_include :category
    end

    it "must have a publication_year" do
      w = works(:oscar_worthy)
      result = w.valid?
      result.must_equal false
      w.errors.messages.must_include :publication_year
    end

    it "must have a creator" do
      w = works(:must_read)
      result = w.valid?
      result.must_equal false
      w.errors.messages.must_include :creator
    end
  end

  describe "relations" do
    it "must have votes" do
        w = works(:awesome_movie)
        w.votes.count.must_equal 1
      end

    it "does not have votes" do
      w = works(:oscar_worthy)
      w.votes.count.must_equal 0
    end
   end
end
