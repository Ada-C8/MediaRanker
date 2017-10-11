require "test_helper"

describe WorksController do
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
