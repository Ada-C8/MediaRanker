require "test_helper"

describe User do
  let(:user) { User.new }

  describe "validations" do
    it "must not be valid without a name" do
      is_valid = user.valid?
      is_valid.must_equal false
    end

    it "must be valid with a name" do
      user.name = "Pamela Isley"
      is_valid = user.valid?
      is_valid.must_equal true
    end

    it "requires a unique name" do
      name = "Harleen Quinzel"
      user_one = User.create!(name: name)
      user_two = User.new(name: name)

      user_two.wont_be :valid?
    end
  end # end validations tests

  describe 'relations' do
    it 'has an association with votes' do
      User.reflect_on_association(:vote)
    end

    it 'responds to votes' do
      user.must_respond_to :votes
    end

    it 'has many votes' do
      u = User.create!(name: "Selina Kyle", id: 1)
      w = Work.create!(title: "Of Mice and Men", id: 1)
      v = Vote.create!(user_id: u.id, work_id: w.id)

      u.votes.must_include v
    end
  end # end relations tests

end
