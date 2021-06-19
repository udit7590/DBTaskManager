class BaseCommand
  attr_accessor :response, :model, :options

  def self.call(*args)
    @options = args.delete(:options) || {}

    if @options[:skip_validation].present?
      object = self.new(*args).run
    else
      object = self.new(*args)
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
