require 'test_helper'

class WorksControllerTest < ActionDispatch::IntegrationTest
  describe "WorksController" do
    let(:gatsby) { works(:gatsby) }

    describe "view pages work" do
      it "going to the home page is successful" do
        get root_path
        must_respond_with :success
      end

      it "going to the index page is successful" do
        get works_path
        must_respond_with :success
      end

      it "going to the add work page is successful" do
        get new_work_path
        must_respond_with :success
      end

      it "should respond with 404 with an invalid work id" do
        get work_path(99999)
        must_respond_with :not_found
      end
    end

    describe "a users can create a work" do
      it "should be able to create a work" do
        proc {
          post works_path, params: { work: { category: "book", title: "New Title"}}
        }.must_change 'Work.count', 1
        must_respond_with :redirect
        must_redirect_to root_path
      end

      it "should re-render form if can't create work" do
        proc { post works_path, params: { work: { category: "book", title: "  "}}}.must_change 'Work.count', 0
        must_respond_with :success
      end
    end

    describe "a users can edit a work" do
      it "should be able to successfully edit a work" do
        put work_path( works(:gatsby)), params: {work: {title: "Updated Title"}}

        updated_work = Work.find( works(:gatsby).id)
        updated_work.title.must_equal "Updated Title"
        must_redirect_to works_path
      end

      it "should be re-render if it can't edit a work" do
        put work_path( works(:gatsby)), params: {work: {title: "   "}}
        must_respond_with :success
      end
    end

    describe "a user can delete a work" do
      it "successfully deletes a work" do
        proc {(delete work_path(gatsby.id))}.must_change 'Work.count', -1
        must_respond_with :redirect
        must_redirect_to root_path
      end
    end

  end # main describe
end #class
