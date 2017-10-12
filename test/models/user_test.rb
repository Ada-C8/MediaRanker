require "test_helper"

describe User do

  describe "validations" do

    it "can be created with all fields" do
      u = User.new(name: "new user", joined: Date.new)

      u.must_be :valid?

    end

  end

end
