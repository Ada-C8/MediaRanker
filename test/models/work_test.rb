require "test_helper"

describe Work do
  let :category {"album"}
  let :publication_year { 2010 }
  let :description { "I'm a description"}
  let :title { "test name" }
  let :creator { "test" }
  describe "validations" do
    it "must be valid, created with all fields" do
      w = Work.create!(category: category, title: title, publication_year: publication_year, creator: creator, description: description)
      w.must_be :valid?
    end

    it "isn't valid with out a title" do
      w = Work.new(category: category, title: "", publication_year: publication_year, creator: creator, description: description)
      w.wont_be :valid?
      w.errors.messages.must_include :title
    end

    it "isn't valid with out a category" do
      w = Work.new(category: "", title: title, publication_year: publication_year, creator: creator, description: description)
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

  describe "methods" do
  end
end
