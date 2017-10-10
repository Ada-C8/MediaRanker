require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:twilight) { works(:twilight) }
  let(:harry_potter) { works(:harry_potter) }

  it "must have a category" do
    twilight.valid?.must_equal true
    twilight.category = nil
    twilight.valid?.must_equal false
    twilight.errors[:category].must_equal ["can't be blank"]

  end

  it "must have a title" do
    harry_potter.valid?.must_equal true
    harry_potter.title = nil
    harry_potter.valid?.must_equal false
    harry_potter.errors[:title].must_equal ["can't be blank"]

  end
end
