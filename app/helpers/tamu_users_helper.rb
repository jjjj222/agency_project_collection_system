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

  def toggle_admin_button(current, other)
    if other.admin?
      if current.master_admin?
        demote_admin_button other.id
      else
        "Admin"
      end
    else
      make_admin_button other.id
    end
  end

  def make_admin_button(id)
    button_to "Make Admin", make_user_admin_path(id), confirm: "Are you sure?"
  end

  def demote_admin_button(id)
    button_to "Remove Admin", demote_admin_path(id), confirm: "Are you sure?"
  end

end
