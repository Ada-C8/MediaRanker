require "test_helper"

describe Vote do
  let(:vote) { Vote.new }
  let(:one) { votes(:one) }
  let(:two) { votes(:two) }

  it "must have a user" do
    one.valid?.must_equal true
    one.user = nil
    one.valid?.must_equal false
    one.errors[:user].must_equal ["must exist"]
  end

  it "must have a work" do
    two.valid?.must_equal true
    two.work = nil
    two.valid?.must_equal false
    two.errors[:work].must_equal ["must exist"]
    # puts "======="
    # two.errors.each do |col, mes|
    #   puts "#{col}: #{mes}"
    # end
    # puts "======"
  end
end
