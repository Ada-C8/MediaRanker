require "test_helper"

describe "work" do
  describe "validations"do
    it "can be created with all fields" do
      a = Work.new(title: "Test Title", category: "movie", publication_year: 2000, description: "whatever")

      a.must_be :valid?
    end
  end
end
