require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  it "will not be valid if the proper information isn't given" do
    vote.wont_be :valid?
  end
  it "will give an error message for not having media_instance_id  nor user_id" do
    vote.errors.messages.include? :media_instance_id
    vote.errors.messages.include? :user_id
  end

  it "must be valid" do
    votes(:one).must_be :valid?
  end
end
