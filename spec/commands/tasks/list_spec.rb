require 'rails_helper'

RSpec.describe Tasks::List, type: :command do
  let!(:user)     { create(:user, :confirmed, active_campaign_contact_id: '199', contact_tag_id: '102') }
  let!(:current_date) { DateTime.new(2021, 06, 20, 20, 0, 0) }
  let!(:tasks)    do
    [
      create(:task),
      create(:task, user: user, title: 'My random title', status: 'Task::Status::Open', created_at: current_date - 5.days),
      create(:task, user: user, status: 'Task::Status::Open', created_at: current_date - 4.days),
      create(:task, user: user, status: 'Task::Status::Wip', created_at: current_date - 3.days),
      create(:task, user: user, status: 'Task::Status::Wip', created_at: current_date - 2.days),
      create(:task, user: user, title: 'Another title', status: 'Task::Status::Close', created_at: current_date - 1.days),
      create(:task, user: user, status: 'Task::Status::Close', created_at: current_date)
    ]
  end
  let!(:params)   { { status: 'Task::Status::Close' } }

  subject { described_class.call(user: user, params: params) }

  context 'when no filters' do
    let(:params) { {} }

    it 'returns records' do
      expect(subject.success?).to eq(true)
      expect(subject.model.count).to eq(6)
    end
  end

  context 'when status filter' do
    let(:params) { { status: 'Task::Status::Wip' } }

    it 'returns records' do
      expect(subject.success?).to eq(true)
      expect(subject.model.count).to eq(2)
      expect(subject.model.map(&:status).uniq).to eq(['Task::Status::Wip'])
    end
  end

  context 'when title filter' do
    let(:params) { { title: 'MY RANDOM Title' } }

    it 'returns records' do
      expect(subject.success?).to eq(true)
      expect(subject.model.count).to eq(1)
      expect(subject.model.map(&:title)).to eq(['My random title'])
    end
  end

  context 'when date filter' do
    let(:params) { { created_at_start: '06-19-2021', created_at_end: '06-20-2021' } }

    it 'returns records' do
      expect(subject.success?).to eq(true)
      expect(subject.model.count).to eq(2)
    end
  end

  context 'when all filters' do
    let(:params) { { created_at_start: '06-19-2021', status: 'Task::Status::Close', title: 'ANOTHER title' } }

    it 'returns records' do
      expect(subject.success?).to eq(true)
      expect(subject.model.count).to eq(1)
    end
  end
end
