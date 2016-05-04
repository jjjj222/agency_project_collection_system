module TamuUsersHelper

  def new_tamu_user_skeleton
    netid = session_netid
    email = "#{netid}@tamu.edu"
    role = 'student' # hopefully we can look this up via netid later
    TamuUser.new(netid: netid, email: email, role: role, admin: false)
  end

  def toggle_admin_button(current, other, opts = {})
    if other.admin?
      if current.master_admin?
        demote_admin_button other.id, opts
      else
        "Admin"
      end
    else
      make_admin_button other.id, opts
    end
  end

  def make_admin_button(id, opts = {})
    opts.reverse_merge!(class: "btn btn-warning")
    button_to "Make Admin", make_user_admin_path(id), confirm: "Are you sure?", :class => opts
  end

  def demote_admin_button(id, opts = {})
    opts.reverse_merge!(class: "btn btn-danger")
    button_to "Remove Admin", demote_admin_path(id), confirm: "Are you sure?", :class => opts
  end

end
