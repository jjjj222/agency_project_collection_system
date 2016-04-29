module SessionsHelper

  def logged_in?
    not current_user_in_session.nil?
  end

  def admin_logged_in?
    current_user.is_a?(TamuUser) && current_user.admin?
  end

  def current_user
    if logged_in?
      current_user_in_session
    else
      nil
    end
  end

  def session_netid
    fix_cas_session
    session[:cas][:user] #TODO: could also ask :extra_attributes['tamuEduPersonNetID']
  end

  def log_in(user, type = user.class.name)
    session[:user_id] = user.id
    session[:user_type] = type.camelize
  end

  def log_out
    session.delete(:user_id)
    session.delete(:user_type)
    @current_user = nil
  end

  def fix_cas_session
    if session[:cas].respond_to?(:symbolize_keys)
      session[:cas] = session[:cas].symbolize_keys
    end
  end

  def cas_logged_in?
    session[:cas] && (session[:cas][:user] || session[:cas]["user"])
  end

  def current_user_in_session
    type = session[:user_type]

    #todo check type get from session is a valid user type
    @current_user ||= type.constantize.find_by(id: session[:user_id]) if type
  end

end
