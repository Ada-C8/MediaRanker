require "test_helper"

describe VotesController do
  before do
    @work_id = Work.find( works(:movie).id ).id

    post login_path, params: { username: "Ada Lovelace"}
  end

  it "must be able to create a vote that has a user and a work" do
    # work_id = Work.find( works(:movie).id ).id
    # post login_path, params: { username: "Ada Lovelace"}

    proc{
      post votes_path, params: { work: @work_id}
    }.must_change 'Vote.count', 1
  end

  ### ummmmmmmmmm
  it "must have a user and a work" do
    # post votes_path, params: { work: @work_id}
  end

  it "must not let a user vote for the same work more than once" do
    work2_id = Work.find( works(:book).id ).id

    post votes_path, params: { work: work2_id}

    proc {
      post votes_path, params: { work: work2_id}
    }.must_change 'Vote.count', 0
  end

  it "can make a new vote for the same work for a new user" do

    work = Work.create(category: "album", title: "Work")

    post login_path, params: { username: "Ada Lovelace"}

    proc {
      post votes_path, params: { work: work.id }
    }.must_change 'Vote.count', 1

    post login_path, params: { username: "Tesla"}

    proc {
      post votes_path, params: { work: work.id }
    }.must_change 'Vote.count', 1
  end

end

# proc {
#   post works_path, params: { work: {category: "album", title: "New Title", creator: "Newton", publication_year: "1983", description: "This is a fantastic album. You should listen to it!"}}
# }.must_change 'Work.count', 1
