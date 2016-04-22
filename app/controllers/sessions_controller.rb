class SessionsController < ApplicationController
  
  skip_before_action :require_login
  
  def tamu_login
    if session[:cas]
      netid = session[:cas]["user"]

      user = TamuUser.find_by(netid: netid)
      if user == nil
        user = TamuUser.create_with_cas(session[:cas])
      end
      log_in(user, "TamuUser")

      redirect_to tamu_user_path(user)
    else
      render status: 401, text: "Redirecting to SSO..."
    end
    #redirect_to root_path
  end

  #def new
  #end
  def tamu_create
    #user_type = params[:user_type]
    #user = user_type.constantize.find_by(email: params[:session][:email].downcase) if user_type
    user = TamuUser.find_by(email: params[:session][:email].downcase)
    #agency = Agency.find_by(email: params[:session][:email].downcase)
    if (user)
      #log_in agency, "Agency"
      #log_in user, user_type
      log_in user, "TamuUser"
      redirect_to tamu_user_path(user.id)
    else
      flash.now[:notice] = 'Invalid email/password combination'
      render 'new'
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
