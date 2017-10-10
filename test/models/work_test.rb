require "test_helper"


describe "validations" do
  let(:work) { Work.new }

  it "requires a category" do
    is_valid = work.valid?
    is_valid.must_be false
    work.error.messages.wont_include :category
  end

end
