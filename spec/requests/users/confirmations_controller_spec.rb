require "rails_helper"

RSpec.describe Users::ConfirmationsController, type: :request do

  describe 'User Confirm' do
    let!(:user) { create(:user, confirmation_token: 'confirmation_token', confirmation_sent_at: DateTime.now) }

    it "confirms user" do
      get "/tasks/new"
      expect(response).to be_successful
      expect(response.body).to include("New Task")

      post "/tasks", params: { task: { title: "My first task", status: 'Task::Status::Open' } }
      task = Task.last

      expect(response).to redirect_to(task)
      follow_redirect!

      expect(response).to be_successful
      expect(response.body).to include("Task was successfully created.")
    end
  end
end
