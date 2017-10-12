require "test_helper"

describe WorksController do

  describe "Work Index" do
    it "should get index" do
      get works_url
      assert_response :success
    end
  end


  describe "Work Show" do
    it "should get the show page of a single work" do
      get work_path(works(:zipangu).id)
      assert_response :success
    end

    it "should redirect to 404 page if user goes to a non-existent work's show page" do
      get work_path(9999)

      assert_response :not_found
    end
  end

  describe "Work New/Create" do
    it "should create a new work" do
      proc {
        post works_path, params: { work: {category: "movie",
          title: "Pokemon: The Movie",
          creator: "Game Freak",
          publication_year: 1997,
          description: "First Pokemon Movie"}  }
        }.must_change 'Work.count', 1
        must_respond_with :redirect, "must redirect to the work's show page after creation"
      end
  end

  describe "Work Destroy" do
    it "should delete a work" do
      proc {
        # run the delete verb on the post_path with a param equal to 1
        delete work_path(works(:poodr).id)
      }.must_change 'Work.count', -1

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "Work Edit/Update" do
    puts "Not done!"
    # it "should update information in a work" do
    #   get works_edit_url
    #   value(response).must_be :success?
    # end
  end



end
