module Users
  class Onboard < BaseCommand
    attr_accessor :current_position

    def initialize(user, *)
      @model = user
    end

    def run
      response    = ActiveCampaignService.call('SyncContact', email: model.email)
      contact_id  = response[:contact].present? && response[:contact][:id]

      return error!('Failed to create contact on ActiveCampaign', error_body: response) if contact_id.blank?

      resource.update_column(:active_campaign_contact_id, contact_id)
      success!
    end
  end
end
