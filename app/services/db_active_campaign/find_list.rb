module DbActiveCampaign
  class FindList < BaseService
    attr_accessor :service, :list_name, :list_id

    def initialize(service, params={})
      @service    = service
      @list_id    = params[:list_id]
      @list_name  = params[:list_name].presence || CreateList::FIRST_LIST[:list_name]
    end

    def call
      return find_list_by_id if list_id.present?

      response = service.client.show_lists(list_name)
      response[1].first if response[1].present?
    end

    def find_list_by_id
      response = service.client.show_list(list_id)
      response[:list].presence
    end
  end
end
