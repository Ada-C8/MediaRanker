require "test_helper"

describe WorksController do
  let(:book1) {works(:book1)}
  let(:book2) {works(:book2)}

  it "should display a form for a new Work" do
    get new_work_path
    must_respond_with :success
  end

  it "should create a new Work" do
    #false
    # post works_path, params: { work: { title: book1.title, category: book1.category} }
    # must_respond_with :error
    #TODO how to test false? this passes, no variables or empty params triggers ::ParameterMissing which is not :error nor :missing response :/

    #true
    proc { post works_path, params: { work: { title: "#{book1.title} 2", category: "book" } } }.must_change 'Work.count', 1

    must_respond_with :redirect
    #TODO must_redirect_to work_path(?HOW?)
  end


end
