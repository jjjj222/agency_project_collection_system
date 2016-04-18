class CasAuthenticatedController < ApplicationController
  include CasAuthenticatedHelper

  def ensure_logged_in
    if not cas_logged_in?
      render status: 401, text: "Redirecting to SSO..."
    end
    fix_cas_session
  end

end
