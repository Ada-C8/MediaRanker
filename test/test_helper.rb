ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...

  def setup
    OmniAuth.config.test_mode = true
  end

  def login(user, provider)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(mock_auth_hash(user))
    get auth_callback_path(:github)
  end

  def mock_auth_hash(user)
    return {
      provider: user.provider,
      uid: user.uid,
      info: {
        email: user.email,
        nickname: user.username      }
    }
  end

  def auth_hash_github
    return {
      provider: "github",
      uid: 777,
      info: {
        email: "new@gmail.com",
        name: "newnew",
        nickname: "new"
      }
    }
  end

  def very_bad_hash
    return {
      provider: "github",
      uid: nil,
      info: {
        email: "boo@gmail.com",
        name: "booboo",
        nickname: "boooooo"
      }
    }
  end

  def auth_hash(user)
    return {
      provider: user.provider,
      uid: user.uid,
      name: user.name,
      info: auth_hash_github[:info]
    }
  end
end
