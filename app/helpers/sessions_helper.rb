module SessionsHelper

  def log_in(user, type = user.class.name)
    session[:user_id] = user.id
    session[:user_type] = type.camelize
  end

  def current_user
    if logged_in?
      current_user_in_session
    else
      nil
    end
  end

  def logged_in?
    if current_user_in_session.nil? && cas_logged_in?
      after_cas_logged_in
    end
    !current_user_in_session.nil?
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

  def after_cas_logged_in
    fix_cas_session
    netid = session[:cas][:extra_attributes]["tamuEduPersonNetID"]
    user = TamuUser.find_by(netid: netid)
    if not user.nil?
      log_in(user)
    else
      flash[:warning] = "Forgetting cas credentials, you are not in the system yet and adding not yet implemented"
    end
  end
  def current_user_in_session
    type = session[:user_type]

    #todo check type get from session is a valid user type
    @current_user ||= type.constantize.find_by(id: session[:user_id]) if type
    #if type == "agency"
    #  @current_user ||= Agency.find_by(id: session[:user_id])
    #else
    #  @current_user ||= TamuUser.find_by(id: session[:user_id])
    #end
  end

end
