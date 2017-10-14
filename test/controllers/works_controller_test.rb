require 'test_helper'

describe "WorkController" do

  describe "Routing works as expected" do
    it "should successfully route to index" do
      get works_path
      must_respond_with :success
    end

    it "should successfully route to show" do
      get work_path(works(:harrypot).id)
      must_respond_with :success
    end

    it "it won't route to show for an id that doesn't exist" do
      id = works(:traveller).id
      delete work_path(id)
      get work_path(id)
      must_redirect_to works_path
    end

    it "should successfully route to new" do
      get new_work_path
      must_respond_with :success
    end

    # it "should successfully route to create" do
    #   post works_path
    #   must_respond_with :success
    # end

    it "should successfully route to edit" do
      get edit_work_path(works(:harrypot).id)
      must_respond_with :success
    end

    # it "should successfully route to update" do
    #   patch work_path(works(:harrypot).id)
    #   must_respond_with :success
    # end
    #
    # it "should successfully route to update" do
    #   put work_path(works(:harrypot).id)
    #   must_respond_with :success
    # end
    #
    # it "should successfully route to destroy" do
    #   delete work_path(works(:harrypot).id)
    #   must_respond_with :success
    # end
  end

  describe "Changes to the database" do

    it "can create a new work" do
      proc { post works_path, params: { work: {category: "book", title: "some book", creator: "some writer", publication_year: 2017, description: "something"}  }}.must_change 'Work.count', 1
      must_respond_with :redirect
    end

    it "won't create a new work when parameters are missing" do
      proc { post works_path, params: { work: {category: "book"} }}.must_change 'Work.count', 0
      must_respond_with :success
    end

    it "can update a work" do
      put work_path(works(:traveller).id), params: {work: {category: "album", title: "some album", creator: "some artist", publication_year: 2017, description: "something"} }

      # find the work with that ID in the database
      work = Work.find(works(:traveller).id)

      # verify the work was changed properly
      work.title.must_equal "some album"
      work.description.must_equal "something"

      must_respond_with :redirect
    end

    it "can't update a work with missing parameters" do
      put work_path(works(:traveller).id), params: {work: {category: "", title: "New title!"} }
      work = Work.find(works(:traveller).id)
      work.title.wont_equal "New title!"
    end

    it "can delete an existing work" do
      proc { delete work_path(works(:traveller).id) }.must_change 'Work.count', -1
      must_respond_with :redirect
    end

    # it "can't delete an non existing work" do
    #   id = works(:traveller).id
    #   proc { delete work_path(id)}.must_change 'Work.count', -1
    #   proc { delete work_path(id)}.must_respond_with :error
    #   must_respond_with :redirect
    # end

  end

end
