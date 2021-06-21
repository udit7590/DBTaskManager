require 'rails_helper'

RSpec.describe Tasks::Create, type: :command do
  let!(:user)     { create(:user, :confirmed, active_campaign_contact_id: '199') }
  let!(:task)     { build(:task, user: user) }

  subject { described_class.call(task) }

  context 'when task is not valid' do
    let!(:task)     { build(:task, user: user, status: 'random') }

    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:task][:status]).to include('is not included in the list')
    end
  end

  context 'when task is valid' do
    context 'when tag not created' do
      include_context "active_campaign_operation_stubs", 'CreateContactTag', 'create_contact_tag' do
        let(:create_contact_tag_params)    { { contact: '199' } }
        let(:create_contact_tag_response)  { { contact_tag: { id: '101' } } }
      end

      it 'returns success' do
        expect(subject.success?).to eq(true)
        expect(task.persisted?).to eq(true)
        expect(user.contact_tag_id).to eq('101')
      end
    end

    context 'when tag already created' do
      let!(:user)     { create(:user, :confirmed, contact_tag_id: '102') }

      it 'returns success' do
        expect(subject.success?).to eq(true)
        expect(task.persisted?).to eq(true)
        expect(user.contact_tag_id).to eq('102')
      end
    end
  end
end
