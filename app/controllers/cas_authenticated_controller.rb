class CasAuthenticatedController < ActionController::Base
  include SessionsHelper

  def ensure_cas_logged_in
    # Unfortunately, we can't access the parameters in this call even after it
    # returns from authentication, so the logic to use the info to log in the
    # user is done in SessionsHelper#logged_in?
    if not logged_in?
      #TODO: handle when logged in as agency
      render status: 401, text: "Redirecting to SSO..."
    end
  end

end
