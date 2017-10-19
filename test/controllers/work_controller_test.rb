require './test/test_helper'


describe WorksController do
  it "should get work home page" do
    get works_path
    assert_response :success
  end

  describe 'works validations' do
    it "get specified valid work id" do
      get works_path(works(:one).id)
      must_respond_with :success
    end

    it "get specified invalid work" do
      get work_path(1321321)
      must_respond_with :missing
    end
  end

  describe 'new works validation' do
    it 'adds a new valid work' do
      post works_path, params: {
        work: {
          title: 'john',
          creator: 'creator 1',
          published: 2010,
          category: 'album',
          description: 'some description'
        }
      }
      must_respond_with :redirect

    end
  end

  it 'should call custom function' do
    t = find_user()
  end

end
