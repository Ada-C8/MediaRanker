require "test_helper"

describe Work do

  let(:work) { Work.new }

  describe "validations" do

    it "can be created with all fields" do
      w = Work.new(category: "album", title: "Infinite Worlds", creator: "Vagabon", publication_year: 2017, description: "On her compact debut, Lætitia Tamko explores ideas of home, community, and sharing space with others who don’t necessarily see eye to eye.")

      w.must_be :valid?
    end

    it "is invalid without a category" do
      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :category
    end

    it "is invalid without a title" do
      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :title
    end

    it "is invalid without a creator" do
      result = work.valid?
      result.must_equal false
      work.errors.messages.must_include :creator
    end
  end

  describe "relations" do
    it "responds to votes" do
      work.must_respond_to :votes
    end
  end

end
