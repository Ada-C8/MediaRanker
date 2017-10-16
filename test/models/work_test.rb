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
    work.errors[:title].must_equal ["has already been taken"]
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
  describe  "self.spotlight" do
    it "should return a work" do
      output = Work.spotlight(Work.all_works_by_title)
      output.must_be_instance_of Work
    end
    it "should return nil if there are no works" do
      output = Work.spotlight(Hash.new)
      output.must_equal nil
    end
    it "should raise an error if input hash does not include works" do
      proc {
        Work.spotlight({one: [1,2,3], two: [1,2,3]})
      }.must_raise ArgumentError
    end
  end
end
