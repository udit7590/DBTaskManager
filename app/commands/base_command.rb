class BaseCommand
  attr_accessor :response, :model, :options

  def self.call(*args, **params)
    @options = params.delete(:options) || {}

    if @options[:skip_validation].present?
      object = self.new(*args, **params).run
    else
      object = self.new(*args, **params)
      object.valid? && object.run
    end
    self
  end

  def response
    @response ||= {}
  end

  def success?
    response[:success].present?
  end

  def fail?
    response[:success] == false
  end

  def success!
    response[:success] = true
  end

  def fail!
    response[:success] = false
  end

  def error!(message=nil, error_body: {})
    errors[:error] = {}
    errors[:error][:message]  = message
    errors[:error][:body]     = error_body
    fail!
  end

  def errors
    response[:errors] ||= {}
  end

  def context
    response[:context] ||= {}
  end

  def valid?
    response[:errors] = {}

    unless model.valid?
      errors.merge!(model.errors.to_h)
    end

    yield if block_given?

    errors.blank?
  end
end
