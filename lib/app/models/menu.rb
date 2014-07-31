class Menu < Sequel::Model
  one_to_many :sections

  def before_save
    super
    puts "CALLING BACK"
    new_path = path.gsub(/[^0-9a-z ]/i, '').gsub(/[\s]/, '-')
    path = new_path
  end
end
