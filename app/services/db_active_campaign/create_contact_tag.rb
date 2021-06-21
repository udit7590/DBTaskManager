module DbActiveCampaign
  class CreateContactTag < BaseService
    attr_accessor :service, :contact_id, :tag_id

    def initialize(service, params={})
      @service    = service
      @contact_id = params[:contact_id]
      @tag_id     = params[:tag_id].presence || ActiveCampaignService.get_first_tag_id
    end

    def call
      service.client.create_contact_tag(
        contact: contact_id,
        tag: tag_id
      )
    end
  end
end
