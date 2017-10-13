require "test_helper"

describe Vote do
  describe "validations" do
    let :user { User.create!(name: "bob") }
    let :work { Work.create!(category: "album", title: "purple rain", creator: "prince", publication_year: 1984, description: "one of the best albums of the year") }
    # it "requires a user id" do
    #   user_id = 1
    #   work_id = 1
    #   v = Vote.new(user_id, work_id)
    #   result = v.valid?
    #   result.must_equal true
    # end

    # it "can be created with all fields" do
    #   u = User.create!
    #   w = Work.create!
    #
    #   v = Vote.new(user_id: u, work_id: w)
    #   result = v.valid?
    #   result.must_equal true
    # end

    it "can be created with all fields" do
      # u = User.new({name: "cheetara"})
      # w = Work.new({category: "album", title: "purple rain", creator: "prince", publication_year: 1984, description: "one of the best albums of the year"})

      v = Vote.new(user: user, work: work)
      result = v.valid?
      result.must_equal true
    end

    it "requires a work id" do
      u = User.new(name: "cheetara")
      v = Vote.new(user_id: u)
      result = v.valid?
      result.must_equal false

      v.errors.messages.must_include :work_id
    end

    it "requires a user id" do
      w = Work.new(category: "album", title: "purple rain", creator: "prince", publication_year: 1984, description: "one of the best albums of the year")
      v = Vote.new(work_id: w)
      result = v.valid?
      result.must_equal false

      v.errors.messages.must_include :user_id
    end
    #
    # it "requires a work_id" do
    #   v = Vote.new
    #   result = v.valid?
    #   result.must_equal false
    # end
  end

  describe "relationships" do
    it "has a user" do
      v = Vote.new(user_id: user.id, work_id: work.id)
      u = User.new(name: "cheetara")

      v.must_respond_to :user
      v.user.must_equal u
      v.user_id.must_equal u.id
    end

    it "has a work" do
      v = Vote.new

      v.must_respond_to :work
      v.work.must_equal work
      v.work_id.must_equal work.id
    end
  end

end
