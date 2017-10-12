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
      user_one = User.create!(name: name, join_date: DateTime.now)
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
  end # end relations tests

end
