require "test_helper"

#test any lines of code you have added to the code


describe Work do
  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(category: "album", title: "test")

      w.must_be :valid?
    end

    it "requires a title" do
      #fail test
      w = Work.new(category: "album")
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :title

      # pass test
      w2 = Work.new(title: "test", category:"movie")
      is_valid = w2.valid?
      is_valid.must_equal true
    end

    it "requires a category" do
      #fail test
      w = Work.new(title: "test")
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :category

      #pass test 
      w2 = Work.new(title: "test", category:"movie")
      is_valid = w2.valid?
      is_valid.must_equal true
    end

  end

  describe "relations" do
    it "has many votes" do
      w = Work.new(category: "album", title: "test")
      w.must_respond_to :votes
      w.votes.must_equal votes
      ## i tried to copy Dan's relationship example where he is
      #checking to see the author id in book equals the author.id
      #and I have a hunch it is not applicable here because Work is a
      #has many instead of a belongs to (as in the ex with Book)
    end

  end

end
