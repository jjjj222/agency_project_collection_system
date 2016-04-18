module CasAuthenticatedHelper
  def fix_cas_session
    if session[:cas].respond_to?(:symbolize_keys)
      session[:cas] = session[:cas].symbolize_keys
    end
  end

  def cas_logged_in?
    session[:cas] && (session[:cas][:user] || session[:cas]["user"])
  end
end
