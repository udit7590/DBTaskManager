module Tasks
  class Create < BaseCommand
    attr_accessor :user

    def initialize(task, **)
      @model  = task
      @user   = task.user
    end

    def run
      if @model.save
        create_contact_tag
        success!
      else
        fail!
      end
    end

    private

    def create_contact_tag
      return if user.contact_tag_id.present?

      response = ActiveCampaignService.call('CreateContactTag', contact_id: user.active_campaign_contact_id)
      user.update_column(:contact_tag_id, response[:contactTag] && response[:contactTag][:id])
    end
  end
end
