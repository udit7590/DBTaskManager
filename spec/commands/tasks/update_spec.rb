require 'rails_helper'

RSpec.describe Tasks::Update, type: :command do
  let!(:user)     { create(:user, :confirmed, active_campaign_contact_id: '199') }
  let!(:task)     { create(:task, user: user, status: 'Task::Status::Wip') }
  let!(:params)   { { status: 'Task::Status::Close' } }

  subject { described_class.call(task, params: params) }

  context 'when task is not valid' do
    let!(:task)     { build(:task, user: user, status: 'random') }

    it 'returns error' do
      expect(subject.success?).to eq(false)
      expect(subject.errors.present?).to eq(true)
      expect(subject.errors[:task][:status]).to include('is not included in the list')
    end
  end

  context 'when task is valid' do
    let!(:user)     { create(:user, :confirmed, active_campaign_contact_id: '199', contact_tag_id: '102') }

    it 'returns success' do
      expect(subject.success?).to eq(true)
      expect(task.persisted?).to eq(true)
      expect(user.contact_tag_id).to eq('102')
    end
  end
end
