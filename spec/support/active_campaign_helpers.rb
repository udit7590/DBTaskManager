module ActiveCampaignHelpers
  def stub_active_campaign_client(client)
    allow(ActiveCampaign::Client).to receive(:new).and_return(client)
  end

  def stub_active_campaign_operation(operation, params: {}, return_value: true)
    allow(operation).to receive(:call).and_return(return_value)
  end

  def stub_active_campaign_service(service)
    allow(ActiveCampaignService).to receive(:new).and_return(service)
  end

  def stub_active_campaign_initial_tag(id="1")
    ActiveCampaignService.instance_variable_set("@first_tag_id", nil)
    allow(ActiveCampaignService).to receive(:call).with('FindTag').and_return({ id: id })
    allow(ActiveCampaignService).to receive(:call).with('CreateTag').and_return({ tag: { id: "2" } }) if id.nil?
  end

  def stub_active_campaign_initial_list(id="1")
    ActiveCampaignService.instance_variable_set("@first_list_id", nil)
    allow(ActiveCampaignService).to receive(:call).with('FindList', { list_id: 1 }).and_return({ id: id })
    allow(ActiveCampaignService).to receive(:call).with('CreateList').and_return({ list: { id: "2" } }) if id.nil?
  end

  def stub_active_campaign_operation_response(client, operation_method, response: {})
    allow(client).to receive(operation_method).and_return(response)
  end
end
