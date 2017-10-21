require "test_helper"

describe User do
let :user1 {users(:santa) }

  describe "valiations" do
      it "is valid" do
        user1.must_be :valid?
      end

      it 'requires a name' do
        b = User.new
        is_valid = b.valid?
        is_valid.must_equal false
        b.errors.messages.must_include :name
      end
    end

    describe "relationships" do
      it "can have a vote" do
        # b = User.new(name: "lauren")
        user1.must_respond_to :votes
      end
    end
end
