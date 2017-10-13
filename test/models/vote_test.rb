require "test_helper"

describe Vote do
  let(:user) { User.first }
  let(:work) { Work.first }
  let(:vote) { Vote.new }

  describe "validations" do
    it "can be created with all fields" do
      vote = Vote.new(
        user_id: user.id,
        work_id: work.id,
      )
      vote.must_be :valid?
    end

    it "cannot be created if the user_id and work_id already exists in the database" do
      first = votes(:vote)
      vote = Vote.new(
        user_id: first.user,
        work_id: first.work
      )

      vote.wont_be :valid?
      vote.errors.messages.must_include :user_id
      vote.errors.messages.must_include :work_id
    end

    it "has a user_id as an integer" do
      vote = Vote.new(user_id: user.id)

      vote.must_respond_to :user
      vote.user_id.must_be_kind_of Integer
    end

    it "is invalid if user_id is not an integer" do
      vote.valid?.must_equal false
      vote.errors.messages.must_include :user_id
    end

    it "has a work_id as an integer" do
      vote = Vote.new(work_id: work.id)

      vote.must_respond_to :work
      vote.work_id.must_be_kind_of Integer
    end

    it "is invalid if work_id is not an integer"do
      vote.valid?.must_equal false
      vote.errors.messages.must_include :work_id
    end

    it "is invalid if the user_id is blank or is not a number" do
    end

    it "is invalid if the work_id is blank or is not a number" do
    end
  end

  describe "relations" do
    it "can set the user through 'user_id'" do
      # Create two models
      # Make the models relate to one another
      vote.user_id = user.id

      # vote should have changed accordingly
      vote.must_respond_to :user
      vote.user.must_equal user
      vote.user_id.must_equal user.id
    end

    it "can set work through work_id" do
      vote.work_id = work.id

      vote.must_respond_to :work
      vote.work.must_equal work
      vote.work_id.must_equal work.id
    end

    # it 'can set the author through "author"' do
    #   # Create two models
    #   author = Author.create!(name: "test author")
    #   book = Book.new(title: "test book")
    #
    #   # Make the models relate to one another
    #   book.author = author
    #
    #   # author_id should have changed accordingly
    #   book.author_id.must_equal author.id
    # end

    # it 'can set the author through "author_id"' do
    #   # Create two models
    #   author = Author.create!(name: "test author")
    #   book = Book.new(title: "test book")
    #
    #   # Make the models relate to one another
    #   book.author_id = author.id
    #
    #   # author should have changed accordingly
    #   book.author.must_equal author
    # end
  end
end


  #must_be(expression, fail_message)
# wont_be(expression, fail_message)
# must_equal(expr1, expr2, fail_message)
# must_include(collection, object, fail_message)
# wont_be_nil(expression, fail_message)
