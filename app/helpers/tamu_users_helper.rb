module TamuUsersHelper
  def session_netid
    fix_cas_session
    session[:cas][:user] #TODO: could also ask :extra_attributes['tamuEduPersonNetID']
  end

  def new_tamu_user_skeleton
    netid = session_netid
    email = "#{netid}@tamu.edu"
    role = 'student' # hopefully we can look this up via netid later
    TamuUser.new(netid: netid, email: email, role: role, admin: false)
  end
end
