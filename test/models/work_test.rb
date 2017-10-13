require "test_helper"

describe Work do
  let :author { Author.first }
  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(title: "new_work", category:"album", creator:"yo", year:2017, description:"nice album")
      w.must_be :valid?
    end

    it "requires a title" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :title
    end

    it "requires a category" do
      w = Work.new(title: "new work")
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :category
    end
  end
end
