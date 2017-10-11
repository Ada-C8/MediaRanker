require "test_helper"

describe 'WorksController' do
  it 'goes to the index page' do
    get works_path
    must_respond_with :success
  end
  it 'goes to a show page given a work id' do
    get work_path( works(:gatsby).id )
    must_respond_with :success
  end
  it 'renders a 404 error if a user tries to show a work that does not exist' do
    get work_path(0)
    must_respond_with 404
  end
  it 'creates a new work' do
    proc {
      post works_path, params: { work: { title: "A New Work", category: "book"}}}.must_change 'Work.count', 1

    must_respond_with :redirect
    must_redirect_to root_path
  end
  it 'renders new if work fails to save' do
    proc {
      post works_path, params: { work: {title: nil, category: "book"}}}.must_change 'Work.count', 0

    must_respond_with :success
  end
  it 'updates an existing work' do
    put work_path( works(:gatsby).id ), params: {work: {description: "You read it in High School"}}

    updated_work = Work.find(works(:gatsby).id)

    updated_work.description.must_equal "You read it in High School"

    must_redirect_to root_path
  end
  it 'renders edit if work fails to update' do
    put work_path( works(:gatsby).id ), params: { work: {category: nil}}

    must_respond_with :success
  end
  it 'destroys a work' do
    proc {delete work_path( works(:gatsby).id )}.must_change 'Work.count', -1

    must_redirect_to root_path
  end
end
