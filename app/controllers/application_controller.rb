class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def after_sign_in_path_for(resource)
    tasks_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def after_confirmation_path_for(resource_name, resource)
    tasks_path
  end
end
