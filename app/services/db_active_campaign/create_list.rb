module DbActiveCampaign
  class CreateList < BaseService
    FIRST_LIST = {
      list_name: 'First List',
      stringid: 'first-list',
      sender_url: 'dbactivecampaign.example.com',
      sender_reminder: 'You are subscribed to the first default list on sign up',
      send_last_broadcast: 0
    }.freeze
    attr_accessor :service, :list_name, :stringid, :sender_url, :sender_reminder, :send_last_broadcast

    def initialize(service, params={})
      @service              = service
      @list_name            = params[:list_name]            || FIRST_LIST[:list_name]
      @stringid             = params[:stringid]             || FIRST_LIST[:stringid]
      @sender_url           = params[:sender_url]           || FIRST_LIST[:sender_url]
      @sender_reminder      = params[:sender_reminder]      || FIRST_LIST[:sender_reminder]
      @send_last_broadcast  = params[:send_last_broadcast]  || FIRST_LIST[:send_last_broadcast]
    end

    def call
      service.client.create_list(
        name: list_name,
        stringid: stringid,
        sender_url: sender_url,
        sender_reminder: sender_reminder,
        send_last_broadcast: send_last_broadcast
      )
    end
  end
end
