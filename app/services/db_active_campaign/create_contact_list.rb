module DbActiveCampaign
  class CreateContactList < BaseService
    attr_accessor :service, :contact_id. :list_id, :status

    def initialize(service, params={})
      @service      = service
      @contact_id   = params[:contact_id]
      @list_id      = params[:list_id].presence || ActiveCampaignService.get_first_list_id
      @status       = params[:status].presence || "1"
    end

    def call
      service.client.create_contact_list(
        contact: contact_id,
        list_id: list_id,
        status: status
      )
    end
  end
end
