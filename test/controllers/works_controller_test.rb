require "test_helper"

describe WorksController do
  let(:invalid_id) { Work.last.id + 1 }

  describe "#index" do
    it "should get index page" do
      get works_path
      must_respond_with :success
    end

    it "should respond with success if no works in db" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

  describe "#show" do
    it "should return success if given a valid work id" do
      get work_path(works(:dune).id)
      must_respond_with :success
    end

    it "should return not found (404) when given an invalid work id" do
      get work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "#home" do
    it "should get home page" do
      get home_path
      must_respond_with :success

      get root_path
      must_respond_with :success
    end

    it "should respond with success if no works in db" do
      Work.destroy_all
      get root_path
      must_respond_with :success
    end
  end

  describe "#new" do
    it "should get new work page" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "#create" do

    it "should create a new work and redirect to work detail page if given valid data" do
      work_data = {
        work: {
          title: "A Title",
          creator: "Anon",
          category_id: categories(:album).id
        }
      }

      # check work is actually valid
      Work.new(work_data[:work]).must_be :valid?

      start_count = Work.count

      post create_work_path, params: work_data
      must_respond_with :redirect

      must_redirect_to work_path(Work.last.id)
      Work.count.must_equal start_count + 1
    end

    it "should respond with bad request and not add work if given invalid data" do
      invalid_work_data = {
        work: {
          creator: "Random",
          category_id: categories(:album).id
        }
      }

      # confirm work is actually invalid
      Work.new(invalid_work_data[:work]).wont_be :valid?
      start_count = Work.count

      post create_work_path params: invalid_work_data

      must_respond_with :bad_request
      Work.count.must_equal start_count
    end
  end

  describe "#edit" do
    it "should respond with success if given valid work id" do
      get work_path(works(:dune).id)
      must_respond_with :success
    end

    it "should return not found if given invalid work id" do
      get work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "#update" do
    it "should update info and redirect if work exists and data change is valid" do
      # updating category
      new_cat = categories(:album)
      patch update_work_path( works(:dune) ), params: { work: { category_id: new_cat.id } }

      updated_work = Work.find(works(:dune).id)
      updated_work.category.must_equal new_cat

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "should update creator attribute if data valid" do
      new_creator = "New Artist"
      patch update_work_path( works(:dune) ), params: { work: { creator: new_creator } }

      updated_work = Work.find(works(:dune).id)
      updated_work.creator.must_equal new_creator
    end

    it "should update publication year attribute if valid" do
      new_year = 2000
      patch update_work_path( works(:dune) ), params: { work: { publication_year: new_year } }

      updated_work = Work.find(works(:dune).id)
      updated_work.publication_year.must_equal new_year
    end

    it "should update title attribute if valid" do
      new_title = "Dune part 2"
      patch update_work_path( works(:dune) ), params: { work: { title: new_title } }

      updated_work = Work.find(works(:dune).id)
      updated_work.title.must_equal new_title
    end

    it "should return bad request if given invalid data" do
      invalid_creator = nil
      orig_creator = works(:dune).creator
      patch update_work_path( works(:dune) ), params: { work: { creator: invalid_creator } }

      must_respond_with :bad_request

      # confirm data not changed
      works(:dune).creator.must_equal orig_creator
    end

    it "should respond not found if work doesn't exist" do
      patch update_work_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "should delete work and redirect if work is found" do
      start_count = Work.count
      delete delete_work_path(works(:dune).id)

      must_respond_with :redirect
      Work.count.must_equal start_count - 1
    end

    it "should respond with not found if work doesn't exist" do
      start_count = Work.count
      delete delete_work_path(invalid_id)

      must_respond_with :not_found
      Work.count.must_equal start_count
    end
  end

end
