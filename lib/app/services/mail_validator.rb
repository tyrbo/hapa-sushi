class MailValidator
  attr_reader :params, :validated, :valid, :errors

  def initialize(params)
    @params = params
    @validated = false
    @valid = false
    @errors = {}
  end

  def valid?
    validate! unless validated?
    valid
  end

  def validate!
    if !ValidateEmail.validate(params[:email])
      errors[:email] = params[:email] || ''
    end

    if !params[:contactName] || params[:contactName].empty?
      errors[:contactName] = params[:contactName] || ''
    end

    if !params[:comments] || params[:comments].empty?
      errors[:comments] = params[:comments] || ''
    end

    @validated = true

    if errors.count == 0
      @valid = true
    end
  end

  def validated?
    validated
  end
end
