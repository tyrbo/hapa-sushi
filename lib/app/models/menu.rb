class Menu < Sequel::Model
  one_to_many :sections
end
