require "test_helper"

describe Work do
  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(title: "test title", creator: "test creator", publication_year: 2012, category: "book", description: "test test")
      w.must_be :valid?
    end

    it "requires a title" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :title
    end

    it "requires a creator" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :creator
    end

    it "requires a category" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :category
    end
  end

  describe "description" do
    it "rejects descriptions > 500 characters" do
      desc = "t" * 501
      w = Work.new(description: desc)

      is_valid = w.valid?
      is_valid.must_equal false

      w.errors.messages.must_include :description
    end

    it "allow descriptions <= 500 characters" do
      descriptions = [
        "a" * 500,
        "a" * 10,
        "a" * 0
      ]

      descriptions.each do |desc|
        w = Work.new(title: "test", creator: "test creator", category: "album", description: desc)

        w.must_be :valid?
      end
    end
  end

end
