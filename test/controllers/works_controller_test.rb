require "test_helper"

describe WorksController do
  let(:album) { works(:album) }

  it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should get show path with a valid work id" do
    # successful with valid id
    get work_path(album.id)
    must_respond_with :success, "Did not get the show page for a valid id"
    # redirects with invalid id
    get work_path(-1)
    must_respond_with :not_found, "Incorrectly got the show page for invalid id"
  end

  it "should get the new path" do
    get new_work_path
    must_respond_with :success
  end

  describe "creating a new work" do
    it "should add a new work to the db with the create path" do
      work = Work.find_by(title: "A new work")
      work.must_equal nil
      proc {
        post create_work_path, params: {work: {title: "A new work", creator: "A creator"}}
      }.must_change 'Work.count', +1
      must_redirect_to works_path
      work = Work.find_by(title: "A new work")
      work.must_be_instance_of Work
    end

    it "should not create a new work with invalid params" do
      #i need to modify the controller to raise an error here
      #requires a creator
      post create_work_path, params: {work: {title: "A new work", creator: nil}}
      must_respond_with :error
      #requires a title
      post create_work_path, params: {work: {title: nil, creator: "A new creator"}}
      must_respond_with :error
    end

    it "should not create a new work if it is not unique" do
      post create_work_path, params: {work: {title: "A new work", creator: "A new creator"}}
      must_respond_with :redirect
      must_redirect_to works_path
      post create_work_path, params: {work: {title: "A new work", creator: "A new creator"}}
      must_respond_with :error
    end
  end

  it "should get the edit path" do
    #properly gets edit path when a valid id
    get edit_work_path(album.id)
    must_respond_with :success
    #redirects to root_path when invalid id
    Work.find(album.id).destroy
    get edit_work_path(album.id)
    must_respond_with :redirect
    must_redirect_to root_path
  end

  describe "updating a work" do
    it "should update a title correctly" do
      Work.find(album.id).title.wont_equal "a new album title"
      patch update_work_path(album.id), params: {work: {title: "a new album title"}}
      Work.find(album.id).title.must_equal "a new album title"
    end
    it "should update a creator correctly" do
      Work.find(album.id).creator.wont_equal "a new creator"
      patch update_work_path(album.id), params: {work: {creator: "a new creator"}}
      Work.find(album.id).creator.must_equal "a new creator"
    end
    it "should update a publication year correctly" do
      Work.find(album.id).publication_year.wont_equal 1972
      patch update_work_path(album.id), params: {work: {publication_year: 1972}}
      Work.find(album.id).publication_year.must_equal 1972
    end
    it "should update a category correctly" do
      Work.find(album.id).category.wont_equal "movie"
      patch update_work_path(album.id), params: {work: {category: "movie"}}
      Work.find(album.id).category.must_equal "movie"
    end
    it "should update a description correctly" do
      Work.find(album.id).description.wont_equal "a description"
      patch update_work_path(album.id), params: {work: {description: "a description"}}
      Work.find(album.id).description.must_equal "a description"
    end
    it "should not update a field if it makes the work not unique (title, category, creator)" do
      new_album = Work.new(category: "album", title: "MyAlbum", creator: "AnotherCreator")
      proc{new_album.save}.must_change "Work.count", +1
      # attempt to update to all the specs of my fixture, album
      patch update_work_path(new_album.id), params: {work: {creator: "AlbumCreator"}}
      must_respond_with :error
    end
  end

  describe "destroying a work" do
    it "must destroy a work if it has a valid id" do
      proc{Work.find(album.id).destroy}.must_change 'Work.count', -1
    end
  end
end
