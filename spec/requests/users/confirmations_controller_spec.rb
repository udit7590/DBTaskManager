require "rails_helper"

RSpec.describe Users::ConfirmationsController, type: :request do

  describe 'User Confirm' do
    let!(:user) { create(:user, confirmation_token: 'confirmation_token', confirmation_sent_at: DateTime.now) }

    include_context "active_campaign_operation_stubs", 'SyncContact', 'sync_contact' do
      let(:sync_contact_params)    { { email: user.email } }
      let(:sync_contact_response)  { { contact: { id: '199' } } }
    end

    include_context "active_campaign_operation_stubs", 'CreateContactList', 'create_contact_list' do
      let(:create_contact_list_params)    { { contact: '199' } }
      let(:create_contact_list_response)  { { contactList: { id: '101' } } }
    end

    it "confirms user" do
      get user_confirmation_path(confirmation_token: 'confirmation_token')
      expect(response).to redirect_to('/users/sign_in')
      follow_redirect!
    end
  end
end
