class TamuUserPresenter < PresenterBase

  present_obj :tamu_user

  delegate :admin?, :id, :name, :email, to: :tamu_user

  def role
    case tamu_user.role
    when /unapproved_professor/i
      "Faculty (Unapproved)"
    when /professor/i
      "Faculty"
    else
      "Student"
    end
  end

  def profile(name = tamu_user.name, opts = {})
    link_to name, tamu_user_path(tamu_user.id, opts[:params]), opts[:style]
  end

  def edit_link(name = 'Edit Profile', opts = {})
    link_to name, edit_tamu_user_path(tamu_user.id), opts
  end

end
