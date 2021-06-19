module TasksHelper
  def status_options
    Task::Status.constants.map { |status_type| ["Task::Status::#{status_type}".constantize.key, "Task::Status::#{status_type}"] }
  end
end
