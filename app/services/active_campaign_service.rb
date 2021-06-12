class ActiveCampaignService < BaseService
  class OperationUndefinedError < StandardError
    def message
      'The operation you are requesting for is not defined'
    end
  end

  attr_accessor :client, :params, :operation

  # NOTE: This service can be used as follows:
  # Eg1. ActiveCampaignService.call('CreateContact', email: 'abc@example.com', phone: '9999999999')
  # Eg2. ActiveCampaignService.call(CreateContact, email: 'abc@example.com', phone: '9999999999')
  # Eg3. ActiveCampaignService.call(OtherOperation, custom_arg_1: 'abc', custom_arg_2: 'def')
  # => The service raises an exception if unsupported operation is executed
  # => Ensure that the argument requirements of an operation is understood before using the service
  def initialize(operation, **params)
    @operation  = operation.to_s.constantize
    @params     = params&.with_indifferent_access || {}
  rescue NameError => e
    raise OperationUndefinedError
  end

  def call
    DbActiveCampaign::operation.call(self, params)
  end

  protected
  def client
    @client ||= ::ActiveCampaign::Client.new(
      api_url: ENV['ACTIVE_CAMPAIGN_API_URL'],
      api_token: ENV['ACTIVE_CAMPAIGN_API_TOKEN']
    )
  end
end
