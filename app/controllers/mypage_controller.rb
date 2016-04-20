class MypageController < ApplicationController
  def index
    # TODO: this should NOT go to gmail by default
    # if !logged_in?
    #   flash[:notice] = 'Please log in'
    #   redirect_to login_path
    # end
  end
end
