class SessionsController < ApplicationController
  def new
  end

  def create
    user_type = params[:user_type]
    user = user_type.constantize.find_by(email: params[:session][:email].downcase) if user_type
    #agency = Agency.find_by(email: params[:session][:email].downcase)
    if (user)
      #log_in agency, "Agency"
      log_in user, user_type
      redirect_to mypage_path
    else
      flash.now[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
