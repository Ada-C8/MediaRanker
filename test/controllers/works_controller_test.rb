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


  describe 'index' do
    it 'returns success status' do

    end
  end


  describe 'index' do
    it 'returns success status' do

    end
  end

end
