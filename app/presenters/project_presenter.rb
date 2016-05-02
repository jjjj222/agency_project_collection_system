class ProjectPresenter < PresenterBase

  present_obj :project

  delegate :name, :description, :completed?, :id, to: :project
  
  def status(type = project.status)
    case type
    when 'unapproved_completed'
      "Completed (Pending approval)"
    else
      type.capitalize
    end
  end
  
  def status_select(opts = {})
    statuses = (Project.all_statuses - ["completed"]).map{|k| [status(k), k] }

    html_opts = {}
    opts.reverse_merge!({class: 'form-control'})
    select :project, :status, statuses, html_opts, opts
  end

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
