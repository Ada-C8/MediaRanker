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

    it 'has many votes' do
      u = User.create!(name: "Selina Kyle", id: 1)
      w = Work.create!(title: "Of Mice and Men", id: 1)
      v = Vote.create!(user_id: u.id, work_id: w.id)

      w.votes.must_include v
    end
  end # end relations tests
end
