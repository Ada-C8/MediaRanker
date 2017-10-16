require "test_helper"

describe WorksController do

  describe "index" do
    it "gets index and returns a success status for all works" do
      get works_path
      must_respond_with :success
    end

    it "returns a success status when there are no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end

  end

  describe "show" do
    it "returns success when given a valid work id" do
      # Arrange
      work_id = Work.first.id

      # Act
      get work_path(work_id)

      # Assert
      must_respond_with :success

    end

    it "returns not_found when given an invalid work id" do
      # Arrange
      invalid_work_id = Work.last.id + 1

      # Act
      get work_path(invalid_work_id)

      # Assert
      must_respond_with :not_found

    end

  end

  describe "edit" do
    it "returns success when given a valid work id" do
      # Arrange
      work_id = Work.first.id

      # Act
      get edit_work_path(work_id)

      # Assert
      must_respond_with :success

    end

    it "returns not_found when given an invalid work id" do
      # Arrange
      work_id = Work.last.id + 1

      # Act
      get edit_work_path(work_id)

      # Assert
      must_respond_with :not_found

    end

  end


  describe "new" do

    it "gets new and returns a success status for the new page" do
      get new_work_path
      must_respond_with :success
    end

  end

  describe "create" do
    it "redirects to show page when the book data is valid" do
      #Arrange
      work_data = {
        work: {
          category: "album",
          title: "Test album"
        }
      }

      Work.new(work_data[:work]).must_be :valid?
      test_work = Work.create!(work_data[:work])

      start_work_count = Work.count

      #Act
      proc {
        post works_path, params: work_data
      }.must_change 'Work.count', 1


      #Assert
      must_respond_with :redirect
      must_redirect_to work_path(test_work.id+1)

      Work.count.must_equal start_work_count + 1
    end

    it "sends bad_request when the work data is bogus" do
      #Arrange
      # this data is not valid because there is no title
      invalid_work_data = {
        work: {
          category: "album",
        }
      }

      # makes sure test breaks if we change the model (i.e., test data no longer vaild)
      Work.new(invalid_work_data[:work]).wont_be :valid?

      start_work_count = Work.count

      #Act
      proc {
        post works_path, params: invalid_work_data
      }.must_change 'Work.count', 0


      #Assert
      must_respond_with :bad_request

      Work.count.must_equal start_work_count
    end
  end

  describe "update" do

    it "returns success if the work exists and the change is valid" do
      work = Work.first
      work_data = {
        work: {
          category: "movie",
          title: "test update action"
        }
      }

      work.update_attributes(work_data[:work])
      work.must_be :valid?

      patch work_path(work.id), params: work_data


      must_respond_with :redirect
      must_redirect_to work_path(work.id)

      work.reload
      work.title.must_equal work_data[:work][:title]
      work.category.must_equal work_data[:work][:category]
    end

    it "returns not_found if the work id is not valid" do
      invalid_work_id = Work.last.id + 1
      work_data = {
        work: {
          category: "movie",
          title: "test update action"
        }
      }

      patch work_path(invalid_work_id), params: work_data

      must_respond_with :not_found
    end

    it "returns bad request if the changes are not valid" do

      w = Work.first
      invalid_work_data = {
        work: {
          title: ""
        }
      }

      w.update_attributes(invalid_work_data[:work])
      w.wont_be :valid?

      patch work_path(w), params: invalid_work_data

      must_respond_with :bad_request

      w.reload
      w.title.wont_equal invalid_work_data[:work][:title]
    end

  end

  describe "destroy" do
    it "returns success if the work id is valid and user is logged in" do
      work_id = Work.first.id
      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }
      post login_path(login_params)

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).must_be_nil
    end

    it "returns not found if the work id is not valid" do
      invalid_work_id = Work.last.id + 1
      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }
      post login_path(login_params)

      start_work_count = Work.count
      delete work_path(invalid_work_id)

      must_respond_with :not_found
      Work.count.must_equal start_work_count
    end

    it "returns failure when a user is not logged in and attempts to delete a work" do
      work_id = Work.first.id

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
      Work.find_by(id: work_id).wont_be_nil
    end
  end

  describe "upvote" do
    it "redirects back and allows upvote when a logged in user upvotes a work they have not previously voted on" do
      work = Work.first
      start_vote_count = work.votes.count
      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }
      post login_path(login_params)

      post upvote_path(work.id)
      work.votes.count.must_equal start_vote_count + 1
      must_respond_with :redirect
    end

    it "redirects back and does not allow an upvote when a logged in user upvotes a work they previously upvoted" do
      work = Work.first
      start_vote_count = work.votes.count
      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }
      post login_path(login_params)

      post upvote_path(work.id)
      post upvote_path(work.id)

      work.votes.count.must_equal start_vote_count + 1
      must_respond_with :redirect
    end

    it "redirects back and allows upvote when a user upvotes a previously upvoted work they have not previously voted on" do
      work = Work.first
      start_vote_count = work.votes.count
      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }

      login_params2 = {
        user: {
          username: "test2",
          date_joined: Date.today
        }
      }
      post login_path(login_params)

      post upvote_path(work.id)

      post logout_path
      session[:logged_in_user].must_equal nil

      post login_path(login_params2)

      post upvote_path(work.id)

      work.votes.count.must_equal start_vote_count + 2
      must_respond_with :redirect
    end

    it "redirects back and does not allow upvote if not logged in" do
      work = Work.first
      start_vote_count = work.votes.count

      login_params = {
        user: {
          username: "test",
          date_joined: Date.today
        }
      }

      post login_path(login_params)
      post logout_path

      session[:logged_in_user].must_equal nil


      post upvote_path(work.id)
      work.votes.count.must_equal start_vote_count
      must_respond_with :redirect
    end
  end
end
