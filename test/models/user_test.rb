require "test_helper"

describe User do
#how to use let in this test??

  describe "valiations" do
      it "is valid" do
        b = User.new(name: "santa")
        b.must_be :valid?
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
        b = User.new(name: "lauren")
        b.must_respond_to :votes
      end
    end
end
