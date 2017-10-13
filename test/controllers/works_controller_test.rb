require "test_helper"

describe WorksController do
  it "generates a successful home page" do
    get home_path
    must_respond_with :success
  end
 it "generates a successful works index page" do
   get works_path
   must_respond_with :success
 end
 it "generates a successful individual work show page" do
   get work_path(works(:movie).id)
   must_respond_with :success
 end
 it "redirects from a failed individual work show page" do
   get work_path(999)
   must_respond_with :redirect
   must_redirect_to works_path
 end
 it "generates a successful new work page" do
   get new_work_path
   must_respond_with :success
 end
 it "should be able to create a work" do
   proc   {
     post works_path, params: { work: {title: "Emotions", creator: "Carly Rae Jepsen"}  }
   }.must_change 'Work.count', 1

   must_respond_with :redirect
   must_redirect_to work_path(Work.find_by(title: "Emotions").id)
 end
 it "should be able to successfully update a work title" do
  patch work_path(works(:kesha)), params: { work: {title: "Rainbow2"}}
  updated_work = Work.find(works(:kesha).id)
  updated_work.title.must_equal "Rainbow2"
  must_redirect_to work_path(works(:kesha).id)
end
it "should be able to delete a work" do
  proc   {
    delete work_path(works(:kesha).id)
  }.must_change 'Work.count', -1

  must_respond_with :redirect
  must_redirect_to root_path
end


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
  # it "should get show" do
  #   get works_show_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get works_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get new" do
  #   get works_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get destroy" do
  #   get works_destroy_url
  #   value(response).must_be :success?
  # end

end
