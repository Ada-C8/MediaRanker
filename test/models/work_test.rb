require "test_helper"

describe Work do
  let(:w) { works(:bladerunner) }

  # it "must be valid" do
  #   value(work).must_be :valid?
  # end


  describe "Validations" do
    it "can be created with all validations" do
      w = Work.create!(title: "The Phantom Menace")

      w.must_be :valid?
    end

    describe "titles" do
      it "requires a title" do
        w = Work.new

        w.wont_be :valid?
        w.errors.messages.must_include :title
      end

      it "requires unique title" do
        w = Work.new(title:"Blade Runner", category: "movie")

        w.wont_be :valid?
        w.errors.messages.must_include :title
      end

      it "allows for title uniqueness within category" do
        x = Work.new(title:"Blade Runner", category: "book")

        x.must_be :valid?
      end
    end
  end
end
