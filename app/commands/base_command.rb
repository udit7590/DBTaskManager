class BaseCommand
  attr_accessor :response, :model, :options, :context

  def self.call(*args, **params)
    @options = params.delete(:options) || {}

    if @options[:skip_validation].present?
      object = self.new(*args, **params).run
    else
      object = self.new(*args, **params)
      object.valid? && object.run
    end
    object
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
    errors[:error] = {
      message: message,
      body: error_body
    }
    fail!
  end

  def errors
    response[:errors] ||= {}.with_indifferent_access
  end

  def errored?
    response[:errors].present?
  end

  def context
    response[:context] ||= {}
  end

  def valid?
    if model.respond_to?(:valid?) && !model.valid?
      key = model.class.name.underscore
      errors[key] = model.errors.to_hash
    end

    yield if block_given?

    errors.blank?
  end
end
