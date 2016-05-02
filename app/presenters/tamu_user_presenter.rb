class TamuUserPresenter < PresenterBase

  present_obj :tamu_user

  delegate :admin?, :id, :name, :email, to: :tamu_user

  def role(type = tamu_user.role)
    case type
    when /unapproved_professor/i
      "Faculty (Unapproved)"
    when /professor/i
      "Faculty"
    else
      "Student"
    end
  end

  def role_select(opts = {})
    roles = ["student", tamu_user.professor? ? "professor" : "unapproved_professor" ]
    roles = roles.map{|k| [role(k), k] }

    html_opts = {}
    opts.reverse_merge!({required: true, class: 'form-control'})
    select :tamu_user, :role, roles, html_opts, opts
  end


  def profile(name = tamu_user.name, opts = {})
    opts[:style] ||= {}
    if tamu_user.admin? and name == tamu_user.name
      opts[:style][:class] = "#{opts[:style][:class]} admin-name" #{class: "admin-name"}.merge(opts[:style])
    end
    link_to name, tamu_user_path(tamu_user.id, opts[:params]), opts[:style]
  end

  def edit_link(name = 'Edit Profile', opts = {})
    link_to name, edit_tamu_user_path(tamu_user.id), opts
  end

  def date
    tamu_user.created_at.to_date
  end

end
