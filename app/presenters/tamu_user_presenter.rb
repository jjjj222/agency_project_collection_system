class TamuUserPresenter < PresenterBase
  present_obj :tamu_user

  delegate :admin?, :id, to: :tamu_user
  present_with :capitalize, :role

  def profile
    link_to tamu_user.name, tamu_user_path(tamu_user)
  end

end
