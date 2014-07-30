module DatabaseHelpers
  def clear_db
    Menu.dataset.delete
  end
end
