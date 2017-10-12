require "test_helper"

# Write at least one test for each custom method on a model
# Write at least one test for each model relationship on a model
# Write at least two tests for each validation on a model

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
      w.errors.messages.wont_include :category
      w.errors.messages.wont_include :title
      w.errors.messages.wont_include :creator
      w.errors.messages.wont_include :description
      w.errors.messages.wont_include :publication_year
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
  end # Describe

end
