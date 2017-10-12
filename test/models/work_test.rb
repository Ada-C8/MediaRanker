require 'test_helper'

describe Work do
  let(:work) { Work.new }

  describe 'validations' do
    it "must have a title to be valid" do
      work.valid?.must_equal false
      work.title = "The Great Gatsby"
      work.save
      work.valid?.must_equal true
    end
  end


end
