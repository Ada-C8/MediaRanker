require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:vote1) { votes(:vote1) }
  let(:user3) { users(:user3) }
  let(:movie) { works(:movie1) }

  describe "relationships" do
    it 'can set the user through "user"' do
      vote1.user = user3

      vote1.user_id.must_equal user3.id
    end

    it 'can set the user through "user_id"' do
      vote1.user_id = user3.id

      vote1.user.must_equal user3
    end

    it 'can set the work through "work"' do
      vote1.work = movie

      vote1.work_id.must_equal movie.id
    end

    it 'can set the work through "work_id"' do
      vote1.work_id = movie.id

      vote1.work.must_equal movie
    end
  end #Relationships
end
