require "test_helper"

describe Vote do
  let :user {User.first}
  let :work {Work.first}
  describe "validations" do
    it "can be created with all fields" do
      v = Vote.new(user: user , work: work)
      v.must_be :valid?
    end

    it "requieres an user" do
      v = Vote.new
      is_valid = v.valid?
      is_valid.must_equal false
      v.errors.messages.must_include :user
    end

    it "requieres a work" do
      v = Vote.new
      is_valid = v.valid?
      is_valid.must_equal false
      v.errors.messages.must_include :work
      #como funciona esto?
    end

    it 'unique couple work and user' do
      w = works(:work1)
      u = users(:user1)
      v = Vote.create!(work_id: w.id, user_id: u.id)
      v1 = Vote.new(work_id: w.id, user_id: u.id)
      is_valid = v1.valid?
      is_valid.must_equal false
    end
  end

  describe 'relations' do
    it 'respond to user and work' do
      #u = user(:user1)
      v = votes(:one)
      v.must_respond_to :user
      v.must_respond_to :work
    end
  end


end
