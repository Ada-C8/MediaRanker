require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "validations" do
    it "can be created with a title" do
      w = Work.new(title: "title")
      w.must_be :valid?
    end

    it "requires a title" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include (:title)
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
