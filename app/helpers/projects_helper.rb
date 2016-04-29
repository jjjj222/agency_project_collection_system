module ProjectsHelper
    def sort_projects(projects, sort, reverse = false)
        case sort
        when "name"
            projects = projects.sort_by {|project| project.name}
        when "date"
            projects = projects.sort_by {|project| project.created_at}
        when "agency"
            projects = projects.sort_by {|project| project.agency.name}
        end

        if reverse
          projects.reverse
        else
          projects
        end
    end
end
