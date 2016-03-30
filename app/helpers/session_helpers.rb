module SessionHelpers
  def current_user
    # TODO
    session[:current_user] || 1
  end
end
