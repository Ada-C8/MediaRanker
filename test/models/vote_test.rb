require "test_helper"

describe Vote do
  let(:harry_vote) { votes(:one) }
  let(:hermione_vote) { votes(:two) }

  it "must be valid" do
    harry_vote.valid?.must_equal true
  end

  it "must only allow one vote per work per user" do
    dup_vote = Vote.new(user_id: users(:harry).id, work_id: works(:hp).id)
    dup_vote.valid?.must_equal false

    dup_vote.work_id = works(:dune).id
    dup_vote.valid?.must_equal true
  end
end
