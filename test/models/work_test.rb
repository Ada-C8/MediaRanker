require "test_helper"

describe Work do
  let :title {"test book title"}

  describe 'validations' do
    # this is the positive test:
    it 'is valid' do
      b = Work.new(title: title)
      b.must_be :valid?
    end

    # all for title: #########################
    # this is the negative test
    it 'requires a title' do
      b = Work.new
      is_valid = b.valid?
      is_valid.must_equal false
      b.errors.messages.must_include :title
    end
    it 'requires a unique title' do
      title = "test book"
      b1 = Work.create!(title: title)
      b2 = Work.new(title: title)
      b2.wont_be :valid?
    end
    # all for description: #########################
    # this is the positive test:
    it "description is acceptable length (<500)" do
      descriptions = [
        "I am less than 500 characters",
        "a" * 500,
        "a" * 10,
        "a" * 0]
        descriptions.each do |desc|
          b = Work.new(title: title, description: desc)

          b.must_be :valid?
        end
      end
      # this is the negative test:
      it "desciption will be invalid if over 500 characters" do
        description = "a" * 501
        b = Work.new(title: title, description: description)
        b.wont_be :valid?
        b.errors.messages.must_include :description
      end
    end

    describe 'relations' do
      it " can have a vote " do
        b = Work.new(title: title)
        b.must_respond_to :votes
      end
    end

  end
