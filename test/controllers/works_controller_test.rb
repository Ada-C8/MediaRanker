require "test_helper"

describe WorksController do

  let(:book1) { works(:book1) }
  let(:book2) { works(:book2) }

  describe "CRUD methods" do
    it "should get index" do
      get works_path
      must_respond_with :success
    end

    it "should get work detail page (#show) or render a 404" do
      #true
      get work_path(book1.id)
      must_respond_with :success

      #false
      book1.destroy
      get work_path(book1.id)
      must_respond_with :not_found
    end

    it "should display a form for a new Work" do
      get new_work_path
      must_respond_with :success
    end

    it "should create a new Work" do
      #false - invalid (without title)
      proc { post works_path, params: { work: { category: "book"} } }.must_change 'Work.count', 0
      must_respond_with :success #renders

      #true
      proc { post works_path, params: { work: { title: "#{book1.title} 2", category: "book" } } }.must_change 'Work.count', 1
      must_respond_with :redirect
    end

    it "should update the work" do
      #true
      old_title = book1.title
      patch work_path(book1.id), params: {work: {title: "#{book1.title} Updated"}}

      book1_updated = Work.find(book1.id)
      book1_updated.title.must_equal "#{old_title} Updated"
      must_redirect_to work_path(book1.id)

      #false - invalid without category
      patch work_path(book2.id), params: { work: { category: nil } }
      book2.category.must_equal "book"
      must_respond_with :success
    end

    it "should display an edit form" do
      #true
      get edit_work_path(book1.id)
      must_respond_with :success

      #false
      book1.destroy
      get edit_work_path(book1.id)
      must_respond_with :not_found
    end

    it "should destroy a Work" do
      proc { delete delete_work_path(book1.id) }.must_change 'Work.count', -1
      must_respond_with :redirect

      Work.find_by(id: book1.id).must_equal nil
    end

  end # CRUD Tests

  describe "Other Controller Methods" do
    it "should display a root page" do
      get root_path
      must_respond_with :success


      #TODO flesh out when you decide where which methods live between Controller and Model
    end
  end
end
