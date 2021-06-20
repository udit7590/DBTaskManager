require "rails_helper"

RSpec.describe TasksController, type: :request do

  describe 'Task Create' do
    let!(:user) { create(:user, :confirmed, contact_tag_id: '101') }
    before do
      sign_in user
    end

    it "creates/updates a Task and redirects to the Task's page" do
      get "/tasks/new"
      expect(response).to be_successful
      expect(response.body).to include("New Task")

      post "/tasks", params: { task: { title: "My first task", status: 'Task::Status::Open' } }
      task = Task.last

      expect(response).to redirect_to(task)
      follow_redirect!

      expect(response).to be_successful
      expect(response.body).to include("Task was successfully created.")

      patch task_path(task), params: { task: { status: 'Task::Status::Close' } }
      expect(response).to redirect_to(task)
      follow_redirect!
      expect(response).to be_successful
      expect(response.body).to include("Task was successfully updated.")
    end
  end

  # it "does not render a different template" do
  #   get "/tasks/new"
  #   expect(response).to_not render_template(:show)
  # end
end
