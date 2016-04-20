class MypageController < ApplicationController
  before_action :require_login

  #def index
  #end

  #def profile
  #end

  #def edit
  #end

  def update
      @current_user.update_attributes(user_params)
      redirect_to mypage_profile_path
  end

  private
  def require_login
    if !logged_in?
      flash[:notice] = 'Please log in'
      redirect_to login_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number)
  end
end
