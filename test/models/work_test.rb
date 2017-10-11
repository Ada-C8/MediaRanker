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

    it "will raise an error if category, title, creator, description, publication_year is invalid" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :category
      w.errors.messages.must_include :title
      w.errors.messages.must_include :creator
      w.errors.messages.must_include :description
      w.errors.messages.must_include :publication_year
    end

    it "requires category, title, creator, description, publication_year is invalid" do
      work.must_be :valid?
      work.errors.messages.wont_include :category
      work.errors.messages.wont_include :title
      work.errors.messages.wont_include :creator
      work.errors.messages.wont_include :description
      work.errors.messages.wont_include :publication_year
    end
  end # Describe

end
