require 'rails_helper'

RSpec.describe DbActiveCampaign::SyncContact, type: :service do
  include ActiveCampaignHelpers

  let(:client)      { ActiveCampaign::Client.new }
  let(:operation)   { 'SyncContact' }
  let(:params)      { { email: 'udit@example.com', first_name: "Udit" } }
  let(:service)     { ActiveCampaignService.new(operation, **params) }
  let(:result)      { ActiveCampaignService.call(operation, **params) }
  let(:response)    { {} }

  before do
    stub_active_campaign_client(client)
    stub_active_campaign_service(service)
    stub_active_campaign_operation_response(client, :sync_contact, response: response)
  end

  context 'when request is successful' do
    let(:response) do
      {
        contact: {
          email: "udit@example.com",
          cdate: "2018-09-28T13:50:41-05:00",
          udate: "2018-09-28T13:50:41-05:00",
          orgid: "",
          first_name: "Udit",
          id: "199"
        }
      }
    end
    it 'returns object' do
      expect(result[:contact][:email]).to eq("udit@example.com")
      expect(result[:contact][:first_name]).to eq("Udit")
      expect(result[:contact][:id]).to eq("199")
    end
  end

  context 'when email already exists' do
    let(:params)      { { email: 'udit@example.com', last_name: "Mittal" } }
    let(:response) do
      {
        contact: {
          email: "udit@example.com",
          cdate: "2018-09-28T13:50:41-05:00",
          udate: "2018-09-28T13:50:41-05:00",
          orgid: "",
          first_name: "Udit",
          last_name: "Mittal",
          id: "199"
        }
      }
    end
    it 'returns object' do
      expect(result[:contact][:id]).to eq("199")
      expect(result[:contact][:first_name]).to eq("Udit")
      expect(result[:contact][:last_name]).to eq("Mittal")
    end
  end
end
