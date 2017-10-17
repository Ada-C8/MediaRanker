require "test_helper"

describe Vote do
  describe "validations" do
    # let :user { User.create!(name: "bob") }
    # let :work { Work.create!(category: "album", title: "purple rain", creator: "prince", publication_year: 1984) }

    # it "can be created with all fields" do
    #
    #
    #   v = Vote.new(user: user, work: work)
    #   result = v.valid?
    #   result.must_equal true
    # end

    it "can be created with all fields" do
    u = users(:cheetara)
    w = works(:awesome_movie)

    v = Vote.new(user_id: u.id, work_id: w.id)

    result = v.valid?
    result.must_equal true
    end


    it "requires a work id" do
      u = users(:cheetara)
      v = Vote.new(user_id: u.id)
      result = v.valid?
      result.must_equal false

      v.errors.messages.must_include :work_id
    end

    it "requires a user id" do
      w = works(:awesome_movie)
      v = Vote.new(work_id: w.id)
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
      u = users(:cheetara)
      w = works(:awesome_movie)

      v = Vote.new(user_id: u.id, work_id: w.id)

      v.must_respond_to :user_id
      v.user_id.must_equal u.id
      # v.user_id.must_be_kind_of String
      # v.user.id.must_equal user.id

      v.must_respond_to :work_id
      v.work_id.must_equal w.id
    end
   end
end
