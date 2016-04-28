module ProjectsHelper
    def sort_projects(projects, sort, reverse = false)
        if sort == "name"
            projects = projects.order(:name)
        elsif sort == "date"
            projects = projects.order(:created_at)
        elsif sort == "agency"
            projects = projects.sort_by {|project| project.agency.name}
        end

        if reverse
          projects.reverse
        else
          projects
        end
    end
end
