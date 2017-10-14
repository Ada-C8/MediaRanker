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

  describe 'index' do
    it 'returns success status' do

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


  describe 'index' do
    it 'returns success status' do

    end
  end

end
