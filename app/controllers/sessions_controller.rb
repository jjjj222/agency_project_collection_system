class SessionsController < ApplicationController
  def new
  end

  def create
    agency = Agency.find_by(email: params[:session][:email].downcase)
    if (agency)
      log_in agency, "agency"
      redirect_to agency
    else
      flash[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
