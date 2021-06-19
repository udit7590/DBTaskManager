module DbActiveCampaign
  class CreateContactTag < BaseService
    attr_accessor :service, :contact_id

    def initialize(service, params={})
      @service    = service
      @email      = params[:email]
      @first_name = params[:first_name]
      @last_name  = params[:last_name]
      @phone      = params[:phone]
    end

    def call
      service.client.create_contact(
        email: email,
        first_name: first_name,
        last_name: last_name,
        phone: phone 
      )
    end
  end
end
