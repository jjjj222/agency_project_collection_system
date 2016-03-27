class ProjectsController < ApplicationController    
    def project_params
        params.require(:project).permit(:name, :description, :status, :tags)
    end

    def new_project_params
        params.require(:project).permit(:name, :description, :status, :tags)
    end
    
    def index
        @projects = Project.all
    end
   
    def show
      id = params[:id] # retrieve movie ID from URI route
      @project = Project.find(params[:id])
    end
   
    def new
        @project = Project.new
    end
   
    def create
        @project = Project.create!(new_project_params)
        #if @project.save
        #    flash[:notice] = "#{@project.name} was successfully created."
        redirect_to projects_path
        #else
        #    flash[:notice] = "Failed"
        #    render new_project_path
        #end
        
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
            render edit_movie_path
        end
    end
   
    def delete
        @project = Project.find(params[:id]).destroy
        flash[:notice] = "Project '#{@project.name}' deleted."
        redirect_to projects_path
    end
    
end

