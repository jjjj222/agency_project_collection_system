module SessionsHelper
  def log_in(user, type)
    session[:user_id] = user.id
    session[:type] = type
  end

  def current_user
    type = session[:type]
    if type == "agency"
      @current_user ||= Agency.find_by(id: session[:user_id])
    else
      @current_user ||= TamuUser.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    session.delete(:type)
    @current_user = nil
  end
end
