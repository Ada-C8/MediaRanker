require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "validations" do
    it "can be created with a title and a category" do
      w = Work.new(title: "title", category: "category")
      w.must_be :valid?
    end

    it "requires a title and a category" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include (:title)
      w.errors.messages.must_include (:category)
    end
  end

  describe "relations" do
    #work has_many votes
    it "must respond to " do
      w = Work.new(title: "title")
      w.must_respond_to :vote
    end

  end

  # describe "custom methods" do
  #
  # end
end
