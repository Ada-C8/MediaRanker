require './test/test_helper'

=begin
1 test for each custom model method
1 test for each relationship
2 tests for validation
2 tests on scope
=end

describe Work do
  it "must be invalid" do
    work = Work.new
    result = work.valid?
    result.must_equal false
    work.errors.keys.must_include :creator
    work.errors.keys.must_include :title
    work.errors.keys.must_include :published
    work.errors.keys.must_include :category
    work.errors.keys.must_include :description
  end

  it "must be valid" do
    work = Work.new
    work.title = 'Title 1'
    work.creator = 'Creator 1'
    work.published = 2000
    work.category = 'album'
    work.description = 'hello my old friend'
    result = work.valid?
  end


end
