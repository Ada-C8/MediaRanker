require "test_helper"

describe Work do
  let :category { "album" }
  let :title { "test name" }

  describe "validations" do
    it "is valid" do
      w = Work.create!(category: category, title: title)
      w.must_be :valid?
    end

    it "isn't valid with out a title" do
      w = Work.new
      w.wont_be :valid?
      w.errors.messages.must_include :title
    end

    it "isn't valid with out a category" do
      w = Work.new
      w.wont_be :valid?
      w.errors.messages.must_include :category
    end
  end

  describe "relations" do
    it "responds to vote" do
      w = Work.new(title: "test")
      w.must_respond_to :votes
    end
  end

  # describe "methods" do
  # end
end
