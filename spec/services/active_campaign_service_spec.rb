require 'rails_helper'

RSpec.describe ActiveCampaignService, type: :service do
  include ActiveCampaignHelpers

  let(:client)      { ActiveCampaign::Client.new }
  let(:operation)   { 'InvalidOperation' }
  let(:params)      { { x: 1, y: 2 } }

  subject { described_class.call(operation, **params) }

  before do
    stub_active_campaign_client(client)
  end

  context 'when invalid operation is passed' do
    it 'returns error' do
      expect { subject }.to raise_error(ActiveCampaignService::OperationUndefinedError)
    end
  end

  context 'when valid operation is passed' do
    let(:operation)   { 'CreateContact' }
    let(:operation_klass) { "DbActiveCampaign::#{operation}".constantize }
    let(:active_campaign_service) { ActiveCampaignService.new(operation, **params) }
    before do
      stub_active_campaign_operation(operation_klass, return_value: true)
      allow(ActiveCampaignService).to receive(:new).and_return(active_campaign_service)
    end

    it 'does not return error' do
      expect(operation_klass).to receive(:call).with(active_campaign_service, x: 1, y: 2)
      expect { subject }.to_not raise_error(ActiveCampaignService::OperationUndefinedError)
      expect { subject }.to_not raise_error
    end
  end

  describe 'Class Methods' do
    context '.get_first_tag_id' do
      context 'when tag was already created' do
        before { stub_active_campaign_initial_tag("1") }

        it 'returns first tag id' do
          expect(ActiveCampaignService.get_first_tag_id).to eq("1")
        end
      end

      context 'when tag was not already created' do
        before { stub_active_campaign_initial_tag(nil) }

        it 'returns first tag id' do
          expect(ActiveCampaignService.get_first_tag_id).to eq("2")
        end
      end
    end

    context '.get_first_list_id' do
      context 'when tag was already created' do
        before { stub_active_campaign_initial_list("1") }

        it 'returns first tag id' do
          expect(ActiveCampaignService.get_first_list_id).to eq("1")
        end
      end

      context 'when tag was not already created' do
        before { stub_active_campaign_initial_list(nil) }

        it 'returns first tag id' do
          expect(ActiveCampaignService.get_first_list_id).to eq("2")
        end
      end
    end
  end
end
