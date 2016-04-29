class ProjectPresenter < PresenterBase

  present_obj :project

  delegate :name, :description, :completed?, to: :project
  present_with :capitalize, :status

  def tags
    project.tags.join ","
  end

  def date
    project.created_at.to_date
  end

  def profile(name = project.name, opts = {})
    link_to name, project_path(project.id, opts[:params]), opts[:style]
  end

  def agency_profile(opts = {})
    link_to project.agency.name, agency_path(project.agency), opts
  end

  def edit_button(opts = {})
    opts.reverse_merge!(method: :get)
    button_to "Edit Project", edit_project_path(project), opts
  end

end
