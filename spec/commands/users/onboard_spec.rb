require 'rails_helper'

RSpec.describe Users::Onboard, type: :command do
  let!(:user)     { create(:user) }

  subject { described_class.call(user) }

  context 'when user is not confirmed' do
    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:error][:message]).to eq('User has not yet confirmed the email')
    end
  end

  context 'when user is invalid' do
    let!(:user)     { User.new }
    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:error][:message]).to eq('User has not yet confirmed the email')
      expect(subject.errors[:user][:email]).to include("can't be blank")
      expect(subject.errors[:user][:password]).to include("can't be blank")
    end
  end

  context 'when unable to create contact on ActiveCampaign' do
    let!(:user)     { create(:user, :confirmed) }

    include_context "active_campaign_operation_stubs", 'SyncContact', 'sync_contact' do
      let(:sync_contact_params)    { { email: user.email } }
      let(:sync_contact_response)  { { error: { message: 'already exists' } } }
    end

    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors[:error][:message]).to eq('Failed to create contact on ActiveCampaign')
    end
  end

  context 'when able to create contact on ActiveCampaign but unable to subscribe to master list' do
    let!(:user)     { create(:user, :confirmed) }

    include_context "active_campaign_operation_stubs", 'SyncContact', 'sync_contact' do
      let(:sync_contact_params)    { { email: user.email } }
      let(:sync_contact_response)  { { contact: { id: '199' } } }
    end

    include_context "active_campaign_operation_stubs", 'CreateContactList', 'create_contact_list' do
      let(:create_contact_list_params)    { { contact: '199' } }
      let(:create_contact_list_response)  { { error: { message: 'unable' } } }
    end

    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors[:error][:message]).to eq('Failed to subscribe contact on ActiveCampaign Master List')
    end
  end

  context 'when able to create contact on ActiveCampaign and able to subscribe to master list' do
    let!(:user)     { create(:user, :confirmed, active_campaign_contact_id: "199") }

    include_context "active_campaign_operation_stubs", 'CreateContactList', 'create_contact_list' do
      let(:create_contact_list_params)    { { contact: '199' } }
      let(:create_contact_list_response)  { { contactList: { id: '101' } } }
    end

    it 'returns success' do
      expect(subject.success?).to eq(true)
    end
  end
end
