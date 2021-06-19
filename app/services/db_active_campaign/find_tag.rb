module DbActiveCampaign
  class FindTag < BaseService
    attr_accessor :service, :tag_name

    def initialize(service, params={})
      @service  = service
      @tag_name = params[:tag_name].presence || CreateTag::FIRST_TAG[:tag_name]
    end

    def call
      response = service.client.show_tags(search: tag_name)
      if response[:tags].present?
        response[:tags].first
      end
    end
  end
end
