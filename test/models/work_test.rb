require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:movie) { works(:movie) }
  let(:album) { works(:album) }
  let(:book) { works(:book) }
  let(:user) { users(:one) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it "can find the unique categories using get_categories()" do
    categories = Work.get_categories()
    categories.must_equal ['Album', 'Book', 'Movie']
  end

  it "can find the top works for each category using get_top_works(categories)" do
    works = [album, book, movie]
    categories = Work.get_categories()
    # top_works should be empty when no works have any votes
    top_works = Work.get_top_works(categories)
    top_works.values.each do |value|
      value.must_equal []
    end
    # top_works should contain Work objects when works have votes
    works.each do |a_work|
      Vote.create(user_id: user.id, work_id: a_work.id)
    end
    top_works = Work.get_top_works(categories)
    i = 0
    top_works.values.each do |value|
      value.must_include works[i]
      i+= 1
    end
  end

end
