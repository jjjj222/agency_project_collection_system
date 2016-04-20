class MypageController < ApplicationController
  def index
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number)
  end
end
