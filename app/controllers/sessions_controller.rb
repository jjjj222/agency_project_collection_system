class SessionsController < ApplicationController
  def new
  end

  #def create
  #  user_type = params[:user_type]
  #  user = user_type.constantize.find_by(email: params[:session][:email].downcase) if user_type
  #  #agency = Agency.find_by(email: params[:session][:email].downcase)
  #  if (user)
  #    #log_in agency, "Agency"
  #    log_in user, user_type
  #    redirect_to mypage_path
  #  else
  #    flash.now[:notice] = 'Invalid email/password combination'
  #    render 'new'
  #  end
  #end

  #def destroy
  #  log_out
  #  redirect_to root_path
  #end

  def create
    begin
      #user_type = params[:user_type]
      user_type = "Agency"
      auth_hash = request.env['omniauth.auth']
      user = user_type.constantize.find_by(uid: auth_hash['uid'], provider: auth_hash['provider']) if user_type
      user = Agency.create_with_omniauth(auth_hash)
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
      #redirect_to root_path
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
end
