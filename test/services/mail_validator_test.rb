require_relative '../test_helper'

describe MailValidator do
  def valid_params
    { email: 'real@email.com', contactName: 'joe', comments: 'test' }
  end

  def invalid_params
    { email: 'fake', contactName: '', comments: '' }
  end

  describe '#valid?' do
    it 'returns true for valid params' do
      assert MailValidator.new(valid_params).valid?
    end

    it 'returns false for invalid or missing params' do
      refute MailValidator.new(invalid_params).valid?
    end
  end
end
