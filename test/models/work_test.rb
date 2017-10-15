require "test_helper"

describe Work do
  let(:work) { Work.new }
  describe "validations" do

    #for the following tests I understand the are 'wet' and could be DRYed. At the moment, I am focuesed on completing the assignment. If there is time I will go back and figure out how to utilize the DRYing method taught in class.
    it "create work with all fields" do
      # work = Work.new(
      #   category: "album",
      #   title: "test work",
      #   publication_year: 2017,
      #   desciption: "",
      #   creator: "me",
      # )
      #
      # work.must_be :valid?
    end



    it "requires category" do
      work = Work.new

      result = work.valid?
      result.must_be false
      work.errors.messages.must_include :category
    end

    it "requires title" do
      work = Work.new

      result = work.valid?
      result.must_be false
      work.errors.messages.must_include :title
    end
  end # end describe

  describe "description" do
    it "rejects descriptions >500 char" do
      desc = "a" * 501

      work = Work.new(description: desc)

      result = work.valid?
      result.must_be false
      work.errors.messages.must_include :description
    end # end it

    it "allows description <= 500 char" do
      descriptions = [
        "a" * 500,
        "a" * 10,
        "a" * 0
      ]

      descriptions.each do |desc|
        result = Work.new(category: "album", title: "test", description: desc)

        result.must_be :valid?
      end
    end
  end # end description

  describe "relations" do
    it "has many votes" do

    end
  end
end
