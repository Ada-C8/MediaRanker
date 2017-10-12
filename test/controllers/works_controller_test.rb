require "test_helper"

describe WorksController do

  let(:good_id) { Work.first.id }
  let(:bad_id) { Work.last.id + 1 }
  let(:fake_id) { Work.last.id + 1000 }
  let(:good_work_data) {
    {
      work: {
        category: "album",
        title: "Safety Time",
        creator: "Safety Guy",
      }
    }
  }
  let(:tmi_work_data) {
    {
      work: {
        id: fake_id,
        category: "album",
        title: "TMI Time",
        creator: "TMI Guy",
        publication_year: 2017,
        description: "This is way too much information",
        created_at: DateTime.new(1),
        updated_at: DateTime.new(1)
      }
    }
  }
  let(:bad_work_data) {
    {
      work: {
        category: "album",
        title: "",
        creator: "Safety Guy",
      }
    }
  }

  describe 'index' do
    it 'returns success with full database' do
      get works_path

      must_respond_with :success
    end

    it 'returns success with empty database' do
      Work.destroy_all

      get works_path

      must_respond_with :success
    end

    it 'sorts the database into 3 categories' do
      get works_path

      [
        [:@albums, 'album'],
        [:@books, 'book'],
        [:@movies, 'movie']
      ].each do |list, category|
        controller.instance_variable_get(list).each {|work| work.category.must_equal category}
      end
    end
  end

  describe 'show' do
    it 'returns success if work exists' do
      get work_path(good_id)

      must_respond_with :success
    end

    it 'returns not_found if work does not exist' do
      get work_path(bad_id)

      must_respond_with :not_found
    end
  end

  describe 'new' do
    it 'returns success' do
      get new_work_path

      must_respond_with :success
    end
  end

  describe 'create' do
    it 'successfully creates work and returns :success when data is valid' do
      Work.new(good_work_data[:work]).must_be :valid?
      before_count = Work.count

      post works_path, params: good_work_data
      must_respond_with 302

      Work.count.must_equal (before_count + 1)
      Work.last.title.must_equal "Safety Time"
    end

    it 'does not create work and returns :bad_request when data is invalid' do
      Work.new(bad_work_data[:work]).wont_be :valid?
      before_count = Work.count

      post works_path, params: bad_work_data
      must_respond_with 400

      Work.count.must_equal before_count
    end

    it 'uses strong params to filter user input' do
      Work.new(tmi_work_data[:work]).must_be :valid?
      before_count = Work.count

      post works_path, params: tmi_work_data
      must_respond_with 302

      Work.count.must_equal (before_count + 1)
      Work.last.created_at.wont_equal DateTime.new(1)
      Work.last.id.wont_equal fake_id
      Work.last.title.must_equal "TMI Time"
    end

    it 're-renders new form (without creating) when passed invalid parameters' do
      Work.new(bad_work_data[:work]).wont_be :valid?
      before_count = Work.count

      post works_path, params: bad_work_data
      must_respond_with :bad_request

      Work.count.must_equal before_count
    end
  end

  describe 'edit' do
    it 'returns success if work exists' do
      get edit_work_path(good_id)

      must_respond_with :success
    end

    it 'returns not_found if work does not exist' do
      get edit_work_path(bad_id)

      must_respond_with :not_found
    end
  end

  describe 'update' do
    it 'returns found if work exists and change is valid' do
      patch work_path(good_id), params: good_work_data
      must_respond_with 302

      Work.first.title.must_equal "Safety Time"
    end

    it 'returns not_found if work does not exist' do
      patch work_path(bad_id), params: good_work_data
      must_respond_with 404

      Work.where(title: "Safety Time").must_equal []
    end

    it 'returns bad_request if change is invalid' do
      skip
      patch work_path(good_id), params: {work:{title:""}}
      must_respond_with :bad_request
    end

    it 'uses strong params' do
      patch work_path(good_id), params: tmi_work_data
      must_respond_with 302

      Work.last.created_at.wont_equal DateTime.new(1)
      Work.last.id.wont_equal fake_id
      Work.find(good_id).title.must_equal "TMI Time"
    end
  end

  describe 'destroy' do
    it 'deletes the work and returns :success if work exists' do
      skip

    end

    it 'returns not_found if work does not exist' do
      skip

    end
  end
end
