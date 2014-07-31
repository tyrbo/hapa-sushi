class Menu < Sequel::Model
  include PathBuilder

  one_to_many :sections
end
