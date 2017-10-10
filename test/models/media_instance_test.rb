require "test_helper"

describe MediaInstance do
  let(:media_instance) { MediaInstance.new }

  it "must be valid" do
    value(media_instance).must_be :valid?
  end
end
