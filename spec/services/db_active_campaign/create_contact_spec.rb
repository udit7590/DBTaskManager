require 'rails_helper'

RSpec.describe DbActiveCampaign::CreateContact, type: :service do
  include ActiveCampaignHelpers

  let(:client)      { ActiveCampaign::Client.new }
  let(:operation)   { 'CreateContact' }
  let(:params)      { { email: 'udit@example.com' } }
  let(:service)     { ActiveCampaignService.new(operation, **params) }
  let(:result)      { ActiveCampaignService.call(operation, **params) }
  let(:response)    { {} }

  before do
    stub_active_campaign_client(client)
    stub_active_campaign_service(service)
    stub_active_campaign_operation_response(client, :create_contact, response: response)
  end

  context 'when request is successful' do
    let(:response) do
      {
        contact: {
          email: "udit@example.com",
          cdate: "2018-09-28T13:50:41-05:00",
          udate: "2018-09-28T13:50:41-05:00",
          orgid: "",
          id: "199"
        }
      }
    end
    it 'returns object' do
      expect(result[:contact][:email]).to eq("udit@example.com")
      expect(result[:contact][:id]).to eq("199")
    end
  end

  context 'when email already exists' do
    let(:response) do
      {
        errors: [
          {
            title: "Email address already exists in the system",
            detail: "",
            code: "duplicate",
            source: {
              pointer: "/data/attributes/email"
            }
          }
        ]
      }
    end
    it 'returns errors' do
      expect(result[:contact]).to eq(nil)
      expect(result[:errors].present?).to eq(true)
    end
  end
end
