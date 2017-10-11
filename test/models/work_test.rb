require "test_helper"

describe Work do
  let :work { Work.first }

  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(
        category: "album",
        title: "Can't Buy a Thrill",
        creator: "Steely Dan",
        publication_year: "1972",
        description: "An album description"
      )
      w.must_be :valid?
    end

    it "requires a category, title, creator, description, publication_year" do
      work = Work.new
      is_valid = work.valid?
      is_valid.must_equal false
      work.errors.messages.must_include :category
      work.errors.messages.must_include :title
      work.errors.messages.must_include :creator
      work.errors.messages.must_include :description
      work.errors.messages.must_include :publication_year
    end

  end # Describe

end
