class Section < Sequel::Model
  one_to_many :items

  def left?
    alignment == 'left'
  end

  def right?
    !left?
  end
end
