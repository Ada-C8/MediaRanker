require "test_helper"

describe User do
  let(:jake) { users(:jake) }
  let(:work) { Work.create(title: "News", category: "movie") }
  let(:work2) { Work.create(title: "More News", category: "album") }

  it "must have a name" do
    jake.name = nil
    jake.save

    jake.valid?.must_equal false

    jake.name = "Jake"
    jake.save
    jake.valid?.must_equal true
  end

  it "requires a unique username" do
    proc {User.create(name: "Jake")}.must_change 'User.count', 0
  end

  # it "returns true for include_work? if the user already has a vote for that work" do
  #   # work = Work.create(title: "News", category: "movie")
  #   Vote.create(user: jake, work: work)
  #
  #   jake.include_work?(work).must_equal true
  # end

  # it "returns false for include_work? if the user already has a vote for that work" do
  #   jake.include_work?(work2).must_equal false
  # end
end
