module DbActiveCampaign
  class CreateContact
    attr_accessor :service, :email, :first_name, :last_name, :phone

    def initialize(service, params={})
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
