require "test_helper"

describe WorksController do
  describe "index" do
    it "returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end

  end #index tests

    describe "new" do
      it "gets a new form" do
        get new_work_path
        must_respond_with :success
      end

      # it "works without an author id" do
      #   get new_book_path
      #   must_respond_with :success
      # end
    end #new tests



      describe "create" do
        it "adds the work to the DB and redirects when the work data is valid" do
          # Arrange
          work_data = {
            work: {
              title: "Test work"
            }
          }
          # Test data should result in a valid work, otherwise
          # the test is broken
          Work.new(work_data[:work]).must_be :valid?

          start_work_count = Work.count

          # Act
          post work_path, params: work_data

          # Assert
          must_respond_with :redirect
          must_redirect_to works_path

          Work.count.must_equal start_work_count + 1
        end #adds work test

            it "sends bad_request when the work data is bogus" do
              # Arrange
              invalid_work_data = {
                work: {
                  # NO TITLE!!!
                  creator: "Fake Creator"
                }
              }
              # Double check the data is truly invalid
              Work.new(invalid_work_data[:work]).wont_be :valid?

              start_work_count = Work.count

              # Act
              post works_path, params: invalid_work_data

              # Assert
              must_respond_with :bad_request
              # Vanilla rails doesn't provide any way to do this
              # assert_template :new
              Work.count.must_equal start_work_count
            end #bad request
          end #create

end#all tests


#   describe "index" do

#

#
#     it "returns a success status when given a valid author_id" do
#       get author_books_path(Author.first)
#       must_respond_with :success
#     end
#
#     it "returns something when given a bogus author_id" do
#       bad_author_id = Author.last.id + 1
#       get author_books_path(bad_author_id)
#       must_respond_with :not_found
#     end
#   end
#

#   describe "show" do
#     it "returns success when given a valid work ID" do
#       # Arrange
#       book_id = Book.first.id
#
#       # Act
#       get book_path(book_id)
#
#       # Assert
#       must_respond_with :success
#     end
#
#     it "returns not_found when given an invalid book ID" do
#       invalid_book_id = Book.last.id + 1
#       get book_path(invalid_book_id)
#       must_respond_with :not_found
#     end
#   end
#
#   describe "edit" do
#     it "returns success when given a valid book ID" do
#       # Arrange
#       book_id = Book.first.id
#
#       # Act
#       get edit_book_path(book_id)
#
#       # Assert
#       must_respond_with :success
#     end
#
#     it "returns not_found when given an invalid book ID" do
#       invalid_book_id = Book.last.id + 1
#       get edit_book_path(invalid_book_id)
#       must_respond_with :not_found
#     end
#   end
#
#   describe "update" do
#     it "returns success if the book ID is valid and the change is valid" do
#       book = Book.first
#       book_data = {
#         book: {
#           title: "Changed title",
#           author_id: book.author_id
#         }
#       }
#       book.update_attributes(book_data[:book])
#       book.must_be :valid?
#
#       patch book_path(book), params: book_data
#
#       must_respond_with :redirect
#       must_redirect_to book_path(book)
#
#       # Check that the change went through
#       book.reload
#       book.title.must_equal book_data[:book][:title]
#     end
#
#     it "returns not_found if the book ID is invalid" do
#       invalid_book_id = Book.last.id + 1
#       book_data = {
#         book: {
#           title: "Changed title",
#           author_id: Author.first.id
#         }
#       }
#
#       patch book_path(invalid_book_id), params: book_data
#
#       must_respond_with :not_found
#     end
#
#     it "returns bad_request if the change is invalid" do
#       book = Book.first
#       invalid_book_data = {
#         book: {
#           title: ""
#         }
#       }
#       # Check that the update is actually invalid
#       book.update_attributes(invalid_book_data[:book])
#       book.wont_be :valid?
#
#       patch book_path(book), params: invalid_book_data
#
#       must_respond_with :bad_request
#
#       book.reload
#       book.title.wont_equal invalid_book_data[:book][:title]
#     end
#   end
#
#   describe "destroy" do
#     it "returns success and destroys the book when given a valid book ID" do
#       # Arrange
#       book_id = Book.first.id
#
#       # Act
#       delete book_path(book_id)
#
#       # Assert
#       must_respond_with :redirect
#       must_redirect_to books_path
#       Book.find_by(id: book_id).must_be_nil
#     end
#
#     it "returns not_found when given an invalid book ID" do
#       invalid_book_id = Book.last.id + 1
#
#       start_book_count = Book.count
#
#       delete book_path(invalid_book_id)
#
#       must_respond_with :not_found
#       Book.count.must_equal start_book_count
#     end
#   end
# end
