module DatabaseHelpers
  def clear_db
    Menu.dataset.delete
    Section.dataset.delete
    Item.dataset.delete
    Location.dataset.delete
    Photo.dataset.delete
  end
end
