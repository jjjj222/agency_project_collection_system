class ProjectsController < ApplicationController    
    
    before_action :admin_only, :only=>[:unapproved_index, :unapprove, :approve]
    before_action :agency_only, :only=>[:new, :create, :edit, :update, :destroy]
    before_action :owner_only, :only=>[:edit, :update, :destroy]
    before_action :tamu_user_only, :only=>[:index, :show]
    
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
      @project = Project.find(params[:id])
      if !@project.approved and !current_user.admin?
        redirect_to projects_path
      end
    end
   
    def new
        @project = Project.new
    end
   
    def create
        @project = current_user.projects.build(project_params)
        
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
            flash[:notice] = @project.errors.full_messages.join("<br>")
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
    
    private

    def admin_only
      unless current_user.class.name == "TamuUser" and current_user.admin?
        redirect_to root_path, :alert => "Access denied."
      end
    end
    
    def agency_only
      unless current_user.class.name == "Agency"
          redirect_to root_path :alert => "Access Denied"
      end
    end
    
    def owner_only
        @project = Project.find(params[:id])
        unless current_user == @project.agency
            redirect_to root_path, :alert => "Access denied."
        end
    end
    
    def tamu_user_only
      if params[:id]
        @project = Project.find(params[:id])
        unless current_user.class.name == "TamuUser" or @project.agency == current_user
          redirect_to root_path, :alert => "Access denied."
        end
      else 
        unless current_user.class.name == "TamuUser"
          redirect_to root_path, :alert => "Access denied."
        end
      end
    end
end

