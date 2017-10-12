require "test_helper"

#test any lines of code you have added to the code


describe Work do
  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(category: "album", title: "test")

      w.must_be :valid?
    end

    it "requires a title" do
      w = Work.new(category: "album")
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :title
    end

    it "requires a category" do
      w = Work.new(title: "test")
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :category
    end

  end

  describe "relations" do
  end

end
