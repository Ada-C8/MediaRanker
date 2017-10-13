require "test_helper"

describe Work do
  let(:work) { Work.new }


  describe "validations" do
      it "can be created with all fields" do
        c = Category.create!
        w = Work.new(category: c, title: "test work")
        b.must_be :valid?
      end

      it "requires a title" do
        w = Work.new
        is_valid = b.valid?
        is_valid.must_equal false
        b.errors.messages.must_inlcude :title
      end
    end


    # describe "description" do
    #   it "requires description to have maximum of 500 characters"
    #     desc = "a" * 501
    #     b = Book.create(description: desc)
    #
    #     b.wont_be :valid?
    #     b.errors.messages.must_include :description
    #   end
    #
    #   it "allows descriptions <= 500 characters" do
    #     descriptions = [
    #       "a" * 500,
    #       "a" * 10,
    #       "a" * 0
    #     ]
    #
    #     descriptions.each do |desc|
    #       b = Book.new(title: "test", author: author, description: desc)
    #       b.must_be :valid?
    #     end
    #   end
    # end




  describe "relations" do

    it "has a collection of votes" do
      w = Work.new
      w.must_respond_to :votes
      w.votes.must_be :empty

      v = Vote.create!(name: "test vote")
      w.votes  << v
      w.votes.must_include v
    end
  end
end
