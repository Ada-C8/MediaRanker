require 'test_helper'

describe Work do
  let(:work) { Work.first }

  describe 'validations' do
    it "must have a title to be valid" do
      work.valid?.must_equal false
      work.title = "The Great Gatsby"
      work.save
      work.valid?.must_equal true
    end

    it "must have a unique creator and title combination" do
      work.title = "Grapes of Wrath"
      work.author = "John Steinbeck"
      work.save
      work.valid?.must_equal false

      work.title = "East of Eden"
      work.save
      work.valid?.must_equal true
    end
  end


end
