class SessionsController < ApplicationController
  
  skip_before_action :require_login
  
  #def new
  #end
  def tamu_new
    if not cas_logged_in?
      render status: 401, text: "Redirecting to SSO..."
    end
    if cas_logged_in? and not current_user_in_session
      after_cas_logged_in
    end
  end

  def create
    begin
      auth_hash = get_auth_hash

      user_type = "Agency" # TAMU Users logged in indirectly by CAS

      user = user_type.constantize.find_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      if user == nil
          user = user_type.constantize.create_with_omniauth(auth_hash)
      end

      #user = find_or_create_by()
      #user = Agency.from_omniauth(auth_hash)
      session[:user_id] = user.id
      session[:user_type] = "Agency"
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to agency_path(user)
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
      render 'new'
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      session.delete(:user_type)
      @current_user = nil
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

  def get_auth_hash
    request.env['omniauth.auth']
  end

end
