require "test_helper"

describe VotesController do
  before do
    @work_id = Work.find( works(:movie).id ).id

    post login_path, params: { username: "Ada Lovelace"}
  end

  it "must be able to create a vote" do
    proc{
      post votes_path, params: { work: @work_id}
    }.must_change 'Vote.count', 1
  end

 #Better in models test??
  # it "must have a user and a work" do
  #   album_id = Work.find( works(:album).id ).id
  #
  #   post votes_path, params: {work: album_id}
  #
  #   vote = Vote.find_by(work: album_id)
  #
  #   vote.user.must_be_kind_of User
  #   vote.work.must_be_kind_of Work
  # end

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

  it "won't make a vote without a user signed in" do
    post logout_path

    new_work = Work.create(title: "New Work", category: "album")

    proc {
      post votes_path, params: { work: new_work.id }
    }.must_change 'Vote.count', 0

    post login_path, params: { username: "Ada Lovelace"}
  end

  it "won't make a vote without a work assigned to it" do
    proc {post votes_path}.must_change 'Vote.count', 0
  end
end


# proc {
#   post works_path, params: { work: {category: "album", title: "New Title", creator: "Newton", publication_year: "1983", description: "This is a fantastic album. You should listen to it!"}}
# }.must_change 'Work.count', 1
