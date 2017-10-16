require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid if it has a title" do
    works(:bonito).valid?.must_equal true
    works(:bonito).title = nil
    works(:bonito).valid?.must_equal false
  end

  it "should not be valid if work title already exists" do
    work.title = works(:bonito).title
    work.save.must_equal false
    work.errors.keys.must_include :title
    work.errors[:title].must_equal ["has already been take"]
  end

describe "all_works_by_title" do
  it "should return a hash" do
    output = Work.all_works_by_title
    output.must_be_instance_of Hash
  end

  it "should return values that are arrays" do
    output = Work.all_works_by_title
    output.values.each do |value|
      value.must_be_instance_of Array
    end
  end

  it "the contents of the arrays should be works" do
    output = Work.all_works_by_title
    output.values.each do |value|
      value.each {|element| element.must_be_instance_of Work}
    end
  end
end
end
