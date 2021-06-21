class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Tasks::List.call(params: task_search_params, user: current_user).model
    @tasks = @tasks.page(params[:page]).order(created_at: :desc)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task   = current_user.tasks.build(task_params)
    command = Tasks::Create.call(@task)

    respond_to do |format|
      if command.success?
        # TODO: Move messages to en.yml and use I18n
        format.html { redirect_to @task, notice: "Task was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    command = Tasks::Update.call(@task, params: task_params)
    respond_to do |format|
      if command.success?
        format.html { redirect_to @task, notice: "Task was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :status)
    end

    def task_search_params
      if params[:task].present?
        params.require(:task).permit(:title, :status, :created_at_start, :created_at_end)
      else
        {}
      end
    end
end
