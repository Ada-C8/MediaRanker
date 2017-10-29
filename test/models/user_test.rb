require "test_helper"

describe User do
  describe "validations" do
    let(:user) { User.new }

    it "must be valid with correct validations" do
      users(:one).must_be :valid?
      users(:one).must_be_kind_of User
    end

    it "must only accept a user with email formatting" do
      g = User.new(name: "Joe", email: "an email", oauth_uid: "4", oauth_provider: "github")
      start_count = User.all.length
      g.wont_be :valid?
      g.errors.messages.must_include :email
      g[:email] = "joeschmoe@somemail.com"
      g.must_be :valid?
      g.save
      start_count.must_equal User.all.length - 1
    end

    it "requires the user to have oauth information" do
      g = User.new(name: "Mary", email: "eeeee@mail.com")
      start_count = User.all.length
      g.wont_be :valid?
      g.errors.messages.must_include :oauth_uid
      g.errors.messages.must_include :oauth_provider

      g[:oauth_uid] =  "557"
      g[:oauth_provider] = "github"
      g.must_be :valid?
      g.save

      start_count.must_equal User.all.length - 1
    end
  end

  describe "relationships" do
    it "has many votes" do
      one = users(:one)
      one.must_respond_to :votes
      one.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end
  end

  describe "self.by_auth_hash(auth_hash)" do
    it "has an instance of user" do
      auth_hash = {
        'provider' => "github",
        'uid' => "12345",
        'info' => {'email' => "somebody@somesite.com",
          'nickname' => "Somebody"}
        }
        user_auth = User.by_auth_hash auth_hash
        user_auth.must_be_kind_of User
      end

      it "responds to the proper keys" do
        auth_hash = {
          'provider' => "github",
          'uid' => "12345",
          'info' => {'email' => "somebody@somesite.com",
            'nickname' => "Somebody"}
          }
          user_auth = User.by_auth_hash auth_hash
          user_auth.must_respond_to :oauth_provider
          user_auth.must_respond_to :oauth_uid
          user_auth.must_respond_to :email
          user_auth.must_respond_to :name
        end

        it "has the correct values for user from auth_hash" do
          auth_hash = {
            'provider' => "github",
            'uid' => "12345",
            'info' => {'email' => "somebody@somesite.com",
              'nickname' => "Somebody"}
            }
            user_auth = User.by_auth_hash auth_hash
            user_auth.oauth_provider.must_equal "github"
            user_auth.oauth_uid.must_equal "12345"
            user_auth.email.must_equal "somebody@somesite.com"
            user_auth.name.must_equal "Somebody"
          end
        end

end
