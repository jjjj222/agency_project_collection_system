class ProjectPresenter < PresenterBase
  present_obj :project

  delegate :name, :description, to: :project
  present_with :capitalize, :status

  def tags
    project.tags.join ","
  end

  def date
    project.created_at.to_date
  end

  def profile(opts = {})
    link_to project.name, project_path(project), opts
  end

  def agency_profile(opts = {})
    link_to project.agency.name, agency_path(project.agency), opts
  end

  def edit_button(opts = {})
    opts.reverse_merge!(method: :get)
    button_to "Edit Project", edit_project_path(project), opts
  end

end