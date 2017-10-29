require "test_helper"

describe MediaInstance do
  describe "validations" do
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

  describe "relationships" do
    it "must_respond_to votes" do
      media_instances(:one).must_respond_to :votes
    end
  end

  describe "ten_by_type" do
    it "must be an array" do
      example = MediaInstance.ten_by_type("music")
      example.must_be_kind_of Array
    end

    it "must be an array of media instances" do
      example = MediaInstance.ten_by_type("music")
      example.each do |model|
        model.must_be_kind_of MediaInstance
      end
    end

    it "must get the correct media type" do
        example = MediaInstance.ten_by_type("Music")
        example.each do |model|
          model.media_type.must_equal "music"
      end
    end
  end
end
