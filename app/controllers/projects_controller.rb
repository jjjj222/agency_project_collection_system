class ProjectsController < ApplicationController    
    def project_params
        params[:project][:tags] = params[:project][:tags].split(/(\s|,)+/)
        params.require(:project).permit(:name, :description, :status, :tags)
    end

    def new_project_params
        params[:project][:tags] = params[:project][:tags].split(/(\s|,)+/)
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
        # if new_project_params[:tags]
        #    new_project_params[:tags] = new_project_params[:tags].split(/(\s|,)+/)
        # end
        @project = Project.new(new_project_params)
        
        if @project.save
            flash[:notice] = "#{@project.name} was successfully created."
            redirect_to projects_path
        else
            flash[:notice] = "Failed"
            render action: "new"
        end
        
    end
   
    def edit
        # params[:id][:tags] = params[:id][:tags].split(/(\s|,)+/)
        @project = Project.find(params[:id])
    end
   
    def update
        @project = Project.find(params[:id])
        
        if @project.update_attributes(project_params)
            flash[:notice] = "#{@project.name} was successfully updated."
            redirect_to project_path
        else
            flash[:notice] = "Failed"
            render action: "edit"
        end
    end
   
    def destroy
        @project = Project.find(params[:id]).destroy
        flash[:notice] = "Project '#{@project.name}' deleted."
        redirect_to projects_path
    end
    
end

