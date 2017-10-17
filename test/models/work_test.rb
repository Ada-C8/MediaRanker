require "test_helper"

describe Work do
  let :user {User.first}
  describe "validations" do
    it "can be created with all fields" do
      w = Work.new(title: "new_work", category:"album", creator:"yo", year:2017, description:"nice album")
      w.must_be :valid?
    end

    it "requires a title" do
      w = Work.new
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :title
    end

    it "requires a category" do
      w = Work.new(title: "new work")
      is_valid = w.valid?
      is_valid.must_equal false
      w.errors.messages.must_include :category
    end
  end

  describe "ralations" do
    it 'can set the vote' do
      w = works(:work1)
      u = users(:user1)
      w.must_respond_to :votes
      w.votes.count.must_equal 0
      v = Vote.create!(work_id: w.id, user_id: u.id)
      w.votes.count.must_equal 1
    end
    
  end



  # describe "method sort_all" do
  #   it "sort works by number of votes" do
  #     Work.destroy_all
  #
  #     works_data = {
  #       work1: { title: "Book1", category: "book"}
  #     }
  #
  #     worktry = Work.new(works_data[:work1])
  #
  #     @works = Work.all
  #
  #     user_data = {
  #       user1: {
  #         name: "User1"
  #       }
  #     }
  #
  #     user1 = User.new(user_data[:user1])
  #
  #     some_votes = {
  #       votes1: {
  #         work_id: worktry.id,
  #         user_id: user1
  #       }
  #     }
  #
  #     onevote = Vote.new(some_votes[:votes1])
  #
  #     sorted = @works.sort_all(@works)
  #
  #     sorted.first.title.must_equal "Book1"
  #
  #   end
  # end
end
