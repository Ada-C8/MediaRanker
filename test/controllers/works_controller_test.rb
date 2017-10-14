require "test_helper"

describe WorksController do
  describe 'index' do
    it 'returns success status' do
      get works_path
      must_respond_with :success
    end

    it 'is successful if NO data' do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

  describe 'show' do
    it 'returns success status if valid work item' do
      work = works(:baby)
      get work_path(work.id)
      must_respond_with :success
    end

    it 'returns not found status if invalid work item' do
      bad_id = Work.last.id + 1
      get work_path(bad_id)
      must_respond_with :not_found
    end
  end

  describe 'new' do
    it 'returns success status' do
      get new_work_path
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'should successfully create work data and redirect to root' do
      work_data = {
        work: {
          category: "book",
          title: "Superbook",
          creator: "Me",
          publication_year: 1982
        }
      }

      proc {
        post works_path, params: work_data
      }.must_change 'Work.count', 1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it 'should return bad request if data invalid' do
      work_data = {
        work: {
          category: "book",
          title: "Superbook",
          creator: "Me"
        }
      }

      proc {
        post works_path, params: work_data
      }.must_change 'Work.count', 0

      must_respond_with :bad_request
    end
  end

  describe 'edit' do
    it 'returns success status if valid work item' do
      work = works(:baby)
      get edit_work_path(work.id)
      must_respond_with :success
    end

    it 'returns not found status if invalid work item' do
      bad_id = Work.last.id + 1
      get edit_work_path(bad_id)
      must_respond_with :not_found
    end
  end

  describe 'update' do
    it 'should successfully update work data and redirect to work path' do
      work_data = {
        work: {
          title: "Superbaby"
        }
      }
      work = works(:baby)

      patch work_path(work.id), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
      Work.find(work.id).title.must_equal "Superbaby"
    end

    it 'should return bad request if invalid update is made' do
      work_data = {
        work: {
          title: ""
        }
      }
      work = works(:baby)
      original_title = work.title

      patch work_path(work.id), params: work_data

      must_respond_with :bad_request
      Work.find(work.id).title.must_equal original_title
    end

    it "should return not found if work doesn't exist" do
      work_data = {
        work: {
          title: "Superbaby"
        }
      }
      bad_id = Work.last.id + 1

      patch work_path(bad_id), params: work_data

      must_respond_with :not_found
    end
  end


  describe 'destroy' do
    it 'returns success status' do

    end
  end
end
