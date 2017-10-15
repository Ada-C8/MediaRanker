require "test_helper"

describe User do
  let :user { User.new }

  describe "validations" do
    it "can be created with all fields - name" do
      user.wont_be :valid?
      user[:name] = "Test First User Name"

      user.must_be :valid?
      user.name.must_equal "Test First User Name"
    end

    it "should be invalid if username is blank or has no entry" do
      user.wont_be :valid?
      user.errors.messages.must_include :name
    end

    it "has a username" do
      users(:one).name.must_equal "Owly"
    end

    it "can be created if there are no previous users" do
      User.destroy_all

      User.count.must_equal 0

      user[:name] = "New User"
      user.must_be :valid?
      user.save!

      User.count.must_equal 1
    end
  end # Describe

  describe "uniqueness" do
    it "must raise on error and cannot be saved if the username already exists" do
      # Create a new User instance other than the one already in the db
      user[:name] = "Owly"
      user.save

      user.wont_be :valid?
    end
  end

end # Describe
