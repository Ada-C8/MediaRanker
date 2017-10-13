require "test_helper"

describe "work" do
  describe "validations"do

    it "can be created with all fields" do
      a = Work.new(title: "Test Title", category: "movie", publication_year: 2000, description: "whatever")

      a.must_be :valid?
    end

    it "requires a title" do
      a = Work.new(category: "movie", publication_year: 2000)
      is_valid = a.valid?
      is_valid.must_equal false
      a.errors.messages.must_include :title
    end

    it "requires a category" do
      a = Work.new(title: "Whoot?!", publication_year: 2000)
      is_valid = a.valid?
      is_valid.must_equal false
      a.errors.messages.must_include :category
    end

    it "won't allow a description longer than 500 characters" do
      description = "*" * 501
      b = Work.new(title: "Test Title", category: "movie", description: description)
      b.wont_be :valid?
      b.errors.messages.must_include :description
    end

    it "will allow a description less than 500 characters" do
      work = works(:poodr)
      work.must_be :valid?
    end

  end
end
