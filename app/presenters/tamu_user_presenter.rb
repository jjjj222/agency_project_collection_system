class TamuUserPresenter < PresenterBase
  present_obj :tamu_user

  delegate :admin?, :id, :name, to: :tamu_user

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

  def profile
    link_to tamu_user.name, tamu_user_path(tamu_user.id)
  end

end
