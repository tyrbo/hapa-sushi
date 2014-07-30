require_relative '../test_helper'

describe Section do
  describe '#left?' do
    it 'returns true when the alignment is left' do
      section = Section.new(alignment: 'left')
      assert section.left?
    end

    it 'returns false when the alignment is right' do
      section = Section.new(alignment: 'right')
      assert section.left?
    end
  end
end
