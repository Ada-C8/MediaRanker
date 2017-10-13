require "test_helper"

describe User do
  let(:u) { User.new(name: 'test') }

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
end
