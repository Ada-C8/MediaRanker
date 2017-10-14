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

  describe 'destroy' do
    it 'returns success status' do

    end
  end
end
