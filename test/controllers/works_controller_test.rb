require "test_helper"

describe WorksController do
  let(:work) { works(:book1) }

  it "should get index" do
    get works_path
    must_respond_with :success
  end
  #
  # it "should get new" do
  #   get works_new_url
  #   value(response).must_be :success?
  # end
  #
  it "should get work detail page (#show) or render a 404" do
    get work_path(work.id)
    must_respond_with :success

    get work_path("ada")
    must_respond_with :not_found
  end
  #
  # it "should get create" do
  #   get works_create_url
  #   value(response).must_be :success?
  # end
  #
  it "should update the work" do
    old_title = work.title
    patch work_path(work.id), params: {work: {title: "#{work.title} Updated"}}

    work_updated = Work.find(work.id)
    work_updated.title.must_equal "#{old_title} Updated"
    must_redirect_to work_path(work.id)
  end

  it "should display an edit form" do
    get edit_work_path(work.id)
    must_respond_with :success

    #TODO if no id
  end
  #
  # it "should get destroy" do
  #   get works_destroy_url
  #   value(response).must_be :success?
  # end

end
