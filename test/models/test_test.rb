require "./test/test_helper"

describe Test do
  let(:test) { Test.new }

  it "must be valid" do
    value(test).must_be :valid?
  end
end
