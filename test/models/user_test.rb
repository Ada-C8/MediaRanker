require "test_helper"

describe User do
  let(:u) { User.new(name: 'test') }
  let(:u1) { users(:one) }

  describe 'validations' do
    it 'can be created with valid data' do
      u.must_be :valid?
    end

    it 'requires name' do
      u.name = ''

      u.wont_be :valid?
      u.errors.messages.must_include :name
    end

    it 'requires unique name' do
      u.save
      v = u.dup

      v.wont_be :valid?
      v.errors.messages.must_include :name
    end
  end

  describe 'recommendations' do
    describe '#recs' do
      it 'returns a hash of recommended works' do
        recs = u1.recs

        recs.must_be_kind_of Hash

        Work.find_by(title: recs.keys.first).wont_be :nil?
      end

      it 'returns an empty hash if users has no votes' do
        recs = u.recs

        recs.must_be_kind_of Hash
        recs.count.must_equal 0
      end

      it 'returns an empty hash if all voted works have no other votes' do
        recs = users(:ten).recs

        recs.must_be_kind_of Hash
        recs.count.must_equal 0
      end
    end

    describe "#rec_list" do
      it 'returns an array of recommended works' do
        list = u1.rec_list

        list.must_be_kind_of Array

        Work.find_by(title: list.keys.first).wont_be :nil?
      end

      it 'returns an empty array if users has no votes' do
        list = u.rec_list

        list.must_equal []
      end

      it 'returns an empty array if all voted works have no other votes' do
        list = users(:ten).rec_list

        list.must_equal []
      end
    end
  end
end
