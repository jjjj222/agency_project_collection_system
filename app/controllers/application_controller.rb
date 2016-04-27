class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper
  
  # TODO
  before_action :require_login
  
  private
  
  def require_login
    unless logged_in?
      flash[:error] = "Please log in to access this page."
      redirect_to my_login_path
    end
  end

  def after_cas_logged_in
    fix_cas_session
    netid = session[:cas][:extra_attributes]["tamuEduPersonNetID"]
    user = TamuUser.find_by(netid: netid)
    if not user.nil?
      log_in(user)
      redirect_to profile_for(user)
    else
      redirect_to new_tamu_user_path
    end
  end

  def model_failed_flash(model)
    if model.errors.any?
      flash[:notice] = model.errors.full_messages.join("<br>")
    else
      flash[:notice] = "Failed"
    end
  end

  private

  def admin_only
    unless admin_logged_in?
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def tamu_user_only
    unless current_user.is_a?(TamuUser)
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def approved_or_admin?(model)
    model.approved || admin_logged_in?
  end

end
