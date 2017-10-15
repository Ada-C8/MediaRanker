require "test_helper"

describe Vote do
  let(:user) { User.first }
  let(:work) { Work.first }
  let(:vote) { Vote.new }

  describe "validations" do
    it "can be created with all valid fields" do
      vote = Vote.create!(
        user_id: user.id,
        work_id: works(:movie).id
      )

      vote.must_respond_to :user
      vote.must_respond_to :work
      vote.must_be :valid?
      vote.errors.messages.wont_include :user_id, :work_id
    end

    it "has a user_id as an integer" do
      new_user = User.create(name: "This is a new User")
      vote = Vote.create(user_id: new_user.id, work_id: work.id)

      vote.must_respond_to :user
      vote.user_id.must_be_kind_of Integer
      vote.errors.messages.wont_include :user_id
    end

    it "is invalid if user_id is blank" do
      vote.wont_be :valid?
      vote.errors.messages.must_include :user_id
    end

    it "is invalid if user_id is not an integer" do
      vote[:user_id] = "This is not an integer"
      vote[:work_id] = work.id

      vote.wont_be :valid?
      vote.errors.messages.must_include :user_id
    end

    it "has a work_id as an integer" do
      work = Work.create(
        category: "book",
        title: "Changed Title",
        creator: "J.K. Rowling",
        publication_year: 2001,
        description: "A boy who has a scar"
      )
      vote = Vote.create(user_id: user.id, work_id: work.id)

      vote.must_respond_to :work
      vote.work_id.must_be_kind_of Integer
      vote.errors.messages.wont_include :work_id
    end

    it "is invalid if work_id is blank"do
      vote.wont_be :valid?
      vote.errors.messages.must_include :work_id
    end

    it "is invalid if work_id is not an integer" do
      vote[:user_id] = user.id
      vote[:work_id] = "This is not an integer"

      vote.wont_be :valid?
      vote.errors.messages.must_include :work_id
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
  end # Des

  describe "uniqueness" do
    it "cannot be created if the user voted on the same work" do
      u_id = users(:one).id
      w_id = works(:album).id

      vote = Vote.new(user_id: u_id, work_id: w_id)

      # ActiveRecord::RecordInvalid: Validation failed: User has already been taken

      # puts "This is the user id: #{user.id}"
      # puts "This is the work id: #{work.id}"
      puts "This is the #{vote}"
      puts "This is the errors #{vote.errors.messages}"
    end
  end
end # Des


  #must_be(expression, fail_message)
# wont_be(expression, fail_message)
# must_equal(expr1, expr2, fail_message)
# must_include(collection, object, fail_message)
# wont_be_nil(expression, fail_message)
