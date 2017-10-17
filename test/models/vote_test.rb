require "test_helper"

describe Vote do
  let(:vote) { Vote.new(work_id: Work.first.id, user_id: User.first.id) }

  # it "must be valid" do
  #   value(vote).must_be :valid?
  # end

  describe 'validations' do
    it 'can be created with all validations' do
      vote.must_be :valid?
      vote.errors.messages.must_be :empty?
    end

    it 'requires a user id' do
      vote.user_id = nil

      vote.wont_be :valid?

      vote.errors.messages.must_include :user
    end

    it 'requires a work id' do
      vote.work_id = nil

      vote.wont_be :valid?

      vote.errors.messages.must_include :work
    end

    it 'requires user and vote id combination to be unique' do
      vote.save
      vote2 = Vote.new(work_id: Work.first.id, user_id: User.first.id)
      vote2.wont_be :valid?
    end
  end
end
