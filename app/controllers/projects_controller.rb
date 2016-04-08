class ProjectsController < ApplicationController    
    
    def project_params
        params[:project][:tags] = params[:project][:tags].split(/[\s,]+/)
        params.require(:project).permit(:name, :description, :status, :approved, 'tags': [])
    end
    
    def index
        @projects = Project.where(approved: true)
    end
    
    def unapproved_index
        @projects = Project.where(approved: false)
    end
   
    def show
      id = params[:id] # retrieve movie ID from URI route
      @project = Project.find(params[:id])
    end
   
    def new
        @project = Project.new
    end
   
    def create
        @project = Project.new(project_params)
        
        if @project.save
            flash[:notice] = "#{@project.name} was successfully created."
            redirect_to project_path(@project)
        else
            flash[:notice] = "Failed"
            render action: "new"
        end
        
    end
   
    def edit
        @project = Project.find(params[:id])
    end
   
    def update
        @project = Project.find(params[:id])
        
        if @project.update_attributes(project_params)
            flash[:notice] = "#{@project.name} was successfully updated."
            redirect_to project_path
        else
          if @project.errors.any?
            flash[:notice] = @project.errors.full_messages.join(". ")
          else
            flash[:notice] = "Failed"
          end
            render action: "edit"
        end
    end
   
    def destroy
        @project = Project.find(params[:id]).destroy
        flash[:notice] = "Project '#{@project.name}' deleted."
        redirect_to projects_path
    end
    
    def approve
        @project = Project.find(params[:id])
        @project.approved = true;
        @project.save
        
        if Project.where(approved: false).count > 0
            flash[:notice] = "Project '#{@project.name}' approved."
            redirect_to unapproved_projects_index_path
        else
            flash[:notice] = "Project '#{@project.name}' approved. All projects have been approved."
            redirect_to projects_path
        end
    end
    
    def unapprove
        @project = Project.find(params[:id])
        @project.approved = false;
        @project.save
        flash[:notice] = "Project '#{@project.name}' unapproved."
        redirect_to projects_path
    end
end

