require "test_helper"

describe Work do

  describe "validations" do
    # positive validation case for the working model
    it "can be created with all required fields" do
      work = Work.new(:category => "album", :title => "Liquid Spirit")
      work.must_be :valid?
    end

    it "requires a title" do
      w = Work.new

      w.wont_be :valid?
      w.errors.messages.must_include :title
    end

    it "requires a category" do
      w = Work.new

      w.wont_be :valid?
      w.errors.messages.must_include :category
    end
  end

  describe "relations" do
    it "has a collection of votes" do
      # arrange
      w = Work.new
      w.must_respond_to :votes
      w.votes.must_be :empty?

      w.votes.count.must_equal 0
      vote = Vote.create!(date: Date.today, work_id: w.id)
      # act
      w.votes << vote
      w.votes.count.must_equal 1

      #assert
      w.votes.must_include vote

    end

    it "work can have multiple votes" do

    end
    # Test dependent relationship destroy
    it "can destroy dependent relationship to votes" do

    end
  end

end
