module Users
  class Onboard < BaseCommand
    attr_accessor :contact_id, :contact_list_id

    def initialize(user, **)
      @model = user
    end

    def run
      create_contact    or (return if errored?)
      subscribe_contact or (return if errored?)

      success!
    end

    def valid?
      super { user_confirmed? }
    end

    private

    def user_confirmed?
      unless model.confirmed?
        error!('User has not yet confirmed the email', error_body: model)
      end
      errors.blank?
    end

    def create_contact
      return if model.active_campaign_contact_id.present?

      result        = ActiveCampaignService.call('SyncContact', email: model.email)
      @contact_id   = result[:contact].presence && result[:contact][:id]

      return error!('Failed to create contact on ActiveCampaign', error_body: result) if @contact_id.blank?

      model.update_column(:active_campaign_contact_id, @contact_id)
    end

    def subscribe_contact
      result            = ActiveCampaignService.call('CreateContactList', contact_id: model.active_campaign_contact_id)
      @contact_list_id  = result[:contactList].presence && result[:contactList][:id]

      # TODO: This might be problematic during user email re-confirmation
      error!('Failed to subscribe contact on ActiveCampaign Master List', error_body: result) if @contact_list_id.blank?
    end
  end
end
