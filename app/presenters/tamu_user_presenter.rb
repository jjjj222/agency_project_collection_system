class TamuUserPresenter < PresenterBase
  present_obj :tamu_user

  def profile
    link_to tamu_user.name, tamu_user_path(tamu_user)
  end

  def admin_button
    if tamu_user.admin?
      "Admin"
    else
      button_to "Make Admin", make_user_admin_path(tamu_user)
    end
  end

end
