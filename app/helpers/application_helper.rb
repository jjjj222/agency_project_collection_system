module ApplicationHelper
  def profile_for(user)
    if user.is_a?(Agency)
      agency_path user
    elsif user.is_a?(TamuUser)
      tamu_user_path user
    else
      root_path
    end
  end
end
