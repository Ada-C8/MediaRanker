require "test_helper"

describe WorksController do
  let(:invalid_id) { -2 }

  it "should get index" do
    get works_path
    must_respond_with :success
  end

  describe "#show" do
    it "should get show if book found" do
      get work_path(works(:dune).id)
      must_respond_with :success
    end

    it "should return 404 if not found" do
      get work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "#home" do
    it "should get home page" do
      get home_path
      must_respond_with :success
    end

    it "should get home page as root path" do
      get root_path
      must_respond_with :success
    end
  end

  it "should get new work page" do
    get new_work_path
    must_respond_with :success
  end

  describe "#create" do
    let(:work_params) { { title: "A Title", creator: "Anon", category_id: categories(:album).id, publication_year: 2000 } }

    it "should create a new work" do
      post create_work_path, params: { work: work_params }
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "should increase work count" do
      proc { post create_work_path, params: { work: work_params } }.must_change 'Work.count', 1
    end
  end

  describe "#edit" do
    it "should get edit page" do
      get work_path(works(:dune).id)
      must_respond_with :success
    end

    it "should return 404 if not found" do
      get work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "#update" do
    it "should return 404 if not found" do
      patch update_work_path(invalid_id)
      must_respond_with :not_found
    end

    it "should update category attribute" do
      new_cat = categories(:album)
      patch update_work_path( works(:dune) ), params: { work: { category_id: new_cat.id } }

      updated_work = Work.find(works(:dune).id)
      updated_work.category.must_equal new_cat

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end


  # it "should get new" do
  #   get works_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get works_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get edit" do
  #   get works_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get works_update_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get destroy" do
  #   get works_destroy_url
  #   value(response).must_be :success?
  # end

end
