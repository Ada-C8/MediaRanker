require "test_helper"

describe Vote do
  let(:vote) { Vote.new(work_id: Work.first.id, user_id: User.first.id) }

  # it "must be valid" do
  #   value(vote).must_be :valid?
  # end

  describe 'validations' do
    it 'can be created with all validations' do
      vote.must_be :valid?
    end
  end
end
