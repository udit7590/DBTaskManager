module Users
  class Onboard < BaseCommand
    attr_accessor :current_position

    def initialize(user, *)
      @model = user
    end

    def run
      result      = ActiveCampaignService.call('SyncContact', email: model.email)
      contact_id  = result[:contact].present? && result[:contact][:id]

      return error!('Failed to create contact on ActiveCampaign', error_body: result) if contact_id.blank?

      resource.update_column(:active_campaign_contact_id, contact_id)

      result    = ActiveCampaignService.call('CreateContactList', contact_id: user.contact_id)
      contact_list_id  = result[:contactList].present? && result[:contactList][:id]

      return error!('Failed to subscribe contact on ActiveCampaign Master List', error_body: result) if contact_list_id.blank?

      success!
    end
  end
end
