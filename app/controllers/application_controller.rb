class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def after_sign_in_path_for
    tasks_path
  end

  def after_sign_out_path_for
    new_user_session_path
  end
end
