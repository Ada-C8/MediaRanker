require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
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
