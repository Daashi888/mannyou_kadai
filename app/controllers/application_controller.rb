class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required
  before_action :logged_in, only: [:new]

  def logged_in
    redirect_to tasks_path if current_user
  end
  
  private

  def login_required
    redirect_to new_session_path unless current_user
  end
end
