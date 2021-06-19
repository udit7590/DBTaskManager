module DbActiveCampaign
  class CreateTag < BaseService
    FIRST_TAG = {
      tag_name: 'First task created',
      tagType: 'contact',
      description: 'When the user creates a first task'
    }.freeze
    attr_accessor :service, :tag_name, :tagType, :description

    def initialize(service, params={})
      @service      = service
      @tag_name     = params[:tag_name]     || FIRST_TAG[:tag_name]
      @tagType      = params[:tagType]      || FIRST_TAG[:tagType]
      @description  = params[:description]  || FIRST_TAG[:description]
    end

    def call
      service.client.create_tag(
        tag: tag_name,
        tagType: tagType,
        description: description
      )
    end
  end
end
