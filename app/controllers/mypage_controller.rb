class MypageController < ApplicationController
  def index
    if !logged_in?
      flash[:notice] = 'Please log in'
      redirect_to login_path
    end
  end
end
