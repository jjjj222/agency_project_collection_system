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
      auth_hash = request.env['omniauth.auth']

      user = Agency.find_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      if user.nil?
          user = Agency.create_with_omniauth(auth_hash)
      end

      log_in user
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to agency_path(user)
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
      render 'new'
    end
  end

  def destroy
    if current_user
      log_out
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

end
