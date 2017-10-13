require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:vote1) { votes(:vote1) }
  let(:user3) { users(:user3) }
  let(:movie) { works(:movie1) }

  describe "relationships" do
    it 'can set the user through "user"' do
      vote1.user = user3

      vote1.user_id.must_equal user3.id
    end

    it 'can set the user through "user_id"' do
      vote1.user_id = user3.id

      vote1.user.must_equal user3
    end

    it 'can set the work through "work"' do
      vote1.work = movie

      vote1.work_id.must_equal movie.id
    end

    it 'can set the work through "work_id"' do
      vote1.work_id = movie.id

      vote1.work.must_equal movie
    end
  end #Relationships

  describe "validations" do
    it "must have a user to be valid" do
      #false
      vote.work = movie
      vote.valid?.must_equal false
      vote.errors[:user].must_include "can't be blank"

      #true
      vote.user = user3
      vote.valid?.must_equal true
    end
    #
    # it "must have a category to be valid" do
    #   #false
    #   work.title = "A Title"
    #   work.valid?.must_equal false
    #   work.errors[:category].must_include "can't be blank"
    #
    #   #true
    #   work.category = "album"
    #   work.valid?.must_equal true
    # end
    #
    # it "must have a unique title in relation to its category to be valid" do
    #   # false
    #   new_book = Work.new(title: book.title, category: book.category)
    #   another_book = Work.new(title: book.title, category: book.category)
    #
    #   (new_book && another_book).valid?.must_equal false
    #
    #   #true
    #   new_book.title = "#{book.title} Changed"
    #   new_book.valid?.must_equal true
    #
    #   another_book.category = "album"
    #   another_book.valid?.must_equal true
    # end

  end # validations set
end
