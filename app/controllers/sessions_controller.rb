class SessionsController < ApplicationController
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
      redirect_to mypage_path
    else
      flash.now[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def create
    begin
      auth_hash = request.env['omniauth.auth']

      #user_type = "Agency"
      user_type = get_user_type_by_provider(auth_hash["provider"])

      user = user_type.constantize.find_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      if user == nil
          user = user_type.constantize.create_with_omniauth(auth_hash)
      end

      if (user)
        #user = find_or_create_by()
        #user = Agency.from_omniauth(auth_hash)
        session[:user_id] = user.id
        session[:user_type] = "Agency"
        flash[:success] = "Welcome, #{user.name}!"
        redirect_to mypage_path
      else
        flash.now[:notice] = 'Invalid email/password combination'
        render 'new'
      end
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

  private
  def get_user_type_by_provider(provider)
    if provider == "google_oauth2"
      return "Agency"
    else
      return "TamuUser"
    end
    return nil
  end
end
