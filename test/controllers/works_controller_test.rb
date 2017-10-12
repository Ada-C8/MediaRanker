require "test_helper"

describe WorksController do

  describe "#index" do
    it "returns success" do
      start_work_count = Work.count
      get works_path

      must_respond_with :success
      start_work_count.must_equal Work.count
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path

      must_respond_with :success
      Work.count.must_equal 0
    end
  end # Describe

  describe "#show" do
    it "returns success when the work_id exists" do
      work = Work.first.id

      get work_path(work)

      must_respond_with :success
    end

    it "returns invalid when the work_id does not exist" do
      bad_work_id = Work.last.id + 1

      get work_path(bad_work_id)

      must_respond_with :not_found
    end
  end # Des

  # describe "#new" do
  #   it "Creates an instance work" do
  #
  #   end
  #
  #   it "works without an author_id" do
  #   end
  # end

  describe "#create" do
    it "returns success when all parameters are created" do
      # Arrange
      # Create a new hash of all the data and add that to a new instance
      work_data = {
        work: {
          id: 1,
          category: "book",
          title: "Harry Potter",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy to has a scar",
        }
      }
                # Variable[:hash]
      Work.new(work_data[:work]).must_be :valid?
      start_work_count = Work.count

      # Act # Why does this work?
      post works_path, params: work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path
      Work.count.must_equal start_work_count + 1
    end

    it "returns something if the parameters are invalid" do
      # Arrange
      invalid_data = {
        work: {
          id: 1,
          category: "book",
          title: "",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy to has a scar",
        }
      }

      Work.new(invalid_data[:work]).wont_be :valid?

      start_work_count = Work.count

      # Act # Why does this params: here work when passing is as a hash?
      post works_path, params: invalid_data

      # Assert
      must_respond_with :bad_request
      Work.count.must_equal start_work_count
    end
  end # Des

  describe "update" do
    it "returns success if the work_id exists and the change is valid" do
      work = Work.first

      work_data = {
        work: {
          category: "book",
          title: "Changed Title",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy to has a scar",
        }
      }

      work.must_be :valid?

      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      work.title.must_equal work_data[:work][:title]
    end

    it "returns not_found if the work_id is invalid" do
      invalid_work_id = Work.last.id + 1

      work_data = {
        work: {
          category: "book",
          title: "Changed Title",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy who has a scar",
        }
      }

      patch work_path(invalid_work_id), params: work_data

      must_respond_with :not_found
    end

    it "returns bad_request if the change is invalid" do
      work = Work.first

      invalid_work_data = {
        work: {
          category: "book",
          title: "",
          creator: "J.K. Rowling",
          publication_year: 2001,
          description: "A boy who has a scar",
        }
      }

      work.must_be :valid?

      patch work_path(work), params: invalid_work_data

      must_respond_with :bad_request

      # Check if change went through
      work.reload
      work.title.wont_equal invalid_work_data[:work][:title]
    end
  end # Des

  describe "#destroy" do
    it "returns success when given a valid work ID" do
      before_count = Work.count
      work_id = Work.first.id

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_equal nil
      Work.count.must_equal before_count - 1
    end

    it "returns not found when a given work ID is invalid" do
      invalid_work_id = Work.last.id + 1

      delete work_path(invalid_work_id)

      must_respond_with :not_found
    end
  end
end # Des



# The default status will be a success if you do not set the status
# Book.count will go to the database

# This wll go in the index method
# nothing: true

# head: :not_found

# This goes in the create method
# if @book.save
#   redirect_to _bok_ath
# else
#   render :new, status: :bad_r

# end

# Arrange
    #  book_data = {
    #    book: {
    #      title: "Test book",
    #      author_id: Author.first.id
    #    }
    #  }
    #  # Test data should result in a valid book, otherwise
    #  # the test is broken
    #  Book.new(book_data[:book]).must_be :valid?
     #
    #  start_book_count = Book.count
     #
    #  # Act
    #  post books_path, params: book_data
     #
    #  # Assert
    #  must_respond_with :redirect
    #  must_redirect_to books_path
     #
    #  Book.count.must_equal start_book_count + 1
# If your controller action reads a Model ID from the URL, you need at least 2 cases:
# The ID corresponds to a model in the DB
# The ID is not found in the DB


# describe "create" do
#   it "does soething when the book data is valid" do
#     book_data = {
#       book: {
#         title: "Test Book",
#         author_id: Autho.first.id
#       }
#     }
#
#     Book.new(book_data[:book]).must_be :valid?
#
#     start_book_count = Book.count
#
#     post books_path, params: book_data
#     must_respond_with :redirect
#     must_redirect_to books_path
#
#     Book.count.must_equal start_book_count 1
#   end
