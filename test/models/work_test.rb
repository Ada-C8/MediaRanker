require "test_helper"

describe Work do
  describe "valiations" do
    it "is valid" do
      w = Work.new(title: "Kick Jump Twist")
      w.must_be :valid?
    end

    it "isn't valid if no title, or empty string" do
      w = Work.new
      w.wont_be :valid?

      w.title = ""
      w.wont_be :valid?
      w.errors.messages.must_include :title
    end
  end

  describe "relationships" do
    it "can have a vote" do
      w = Work.new(title: "Kick Jump Twist")
      w.must_respond_to :votes
    end

  end
end
