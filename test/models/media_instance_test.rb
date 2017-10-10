require "test_helper"

describe MediaInstance do
  let(:media_instance) { MediaInstance.new }
  it "must reject if there is no title" do
    media_instance.errors.messages.include? :title
  end
  it "must reject if there is no media type" do
    media_instance.errors.messages.include? :media_type
  end

  it "must be valid" do
    media_instances(:one).must_be :valid?
  end
end
