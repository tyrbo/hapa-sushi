module PathBuilder
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def create_with_path(params)
      obj = new(params)
      obj.path = params[:title].gsub(/[^0-9a-z ]/i, '').gsub(/[\s]/, '-').downcase
      obj.save
    end
  end

  def update_with_path(params)
    params[:path] = params[:title].gsub(/[^0-9a-z ]/i, '').gsub(/[\s]/, '-').downcase
    update(params)
  end
end
