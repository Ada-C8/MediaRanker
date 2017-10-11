require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "validations" do
    it "must not be valid without a title" do
      is_valid = work.valid?
      is_valid.must_equal false
    end

    it "must be valid with a title" do
      work.title = "King Lear"
      is_valid = work.valid?
      is_valid.must_equal true
    end
  end # end validations tests

  describe 'relations' do
    it 'has an association with votes' do
      Work.reflect_on_association(:vote)
    end

    it 'responds to votes' do
      work.must_respond_to :votes
    end
  end # end relations tests
end
