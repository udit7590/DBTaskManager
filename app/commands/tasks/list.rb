module Tasks
  class Create < BaseCommand
    attr_accessor :user, :params

    def initialize(task, params:, filters:, user:)
      @model  = task
      @user   = user
      @params = params
    end

    def run
      if @model.update(params)
        create_contact_tag
        success!
      else
        fail!
      end
    end

    private

    def create_contact_tag
      return if user.contact_tag_id.present?

      response = ActiveCampaignService.call('CreateContactTag', contact_id: user.contact_id)
      user.update_column(:contact_tag_id, response[:contactTag] && response[:contactTag][:id])
    end
  end
end
