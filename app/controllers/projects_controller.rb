class ProjectsController < ApplicationController
    include ProjectsHelper
    
    before_action :admin_only, :only=>[:unapproved_index, :unapprove, :approve, :unapproved_completed_index, :unapprove_completed, :approve_completed]
    before_action :agency_only, :only=>[:new, :create, :edit, :update, :destroy]
    before_action :owner_only, :only=>[:edit, :update, :destroy]
    before_action :tamu_user_or_owner_only, :only => [:show]
    before_action :tamu_user_only, :only=>[:index, :join, :drop]
    
    def project_params
        params[:project][:tags] = params[:project][:tags].split(/[\s,]+/)
        params.require(:project).permit(:name, :description, :status, :approved, 'tags'=> [])
    end
    
    def index
        @projects = Project.where(approved: true)

        if params[:search]
            session[:search] = params[:search]
        end

        if session[:search] && session[:search]['value'] != ""
            @search_value = session[:search]['value']
            @search_type = session[:search]['type']

            search_regex = Regexp.new(Regexp.escape(@search_value), "i")

            @projects = @projects.select do |project|
                if @search_type == "tags"
                    project.tags.grep(search_regex).any?
                else
                    project.send(@search_type) =~ search_regex
                end
            end
        end

        @projects = list_projects(@projects)
    end

    def unapproved_index
        @projects = list_projects Project.where(approved: false)
    end
    
    def unapproved_completed_index
      @projects = Project.where(status: "unapproved_completed")
      @projects = list_projects @projects
    end
   
    def show
      @project = Project.find(params[:id])
      if user_should_not_see? @project
        redirect_to projects_path
      end
    end
   
    def new
        @project = Project.new
    end
   
    def create
        @project = current_user.projects.build(project_params.merge(status: "open"))
        
        if @project.save
            flash[:success] = "#{@project.name} was successfully created."
            redirect_to project_path(@project)
        else
            model_failed_flash @project
            render action: "new"
        end
    end
   
    def edit
        @project = Project.find(params[:id])
    end
   
    def update
        @project = Project.find(params[:id])
        new_params = project_params
        if new_params[:status] == "completed"
            new_params[:status] = "unapproved_completed"
        end
        was_completed = @project.completed?
        
        if @project.update_attributes(new_params)
            if was_completed
              flash[:success] = "#{@project.name} was successfully updated and will need reapproval for completition."
            else
              flash[:success] = "#{@project.name} was successfully updated."
            end
            redirect_to project_path
        else
            model_failed_flash @project
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
            flash[:success] = "Project '#{@project.name}' approved."
            redirect_to unapproved_projects_index_path
        else
            flash[:success] = "Project '#{@project.name}' approved. All projects have been approved."
            redirect_to projects_path
        end
    end
    
    def unapprove
        @project = Project.find(params[:id])
        @project.approved = false;
        @project.save
        flash[:success] = "Project '#{@project.name}' unapproved."
        redirect_to projects_path
    end
    
    def approve_completed
        @project = Project.find(params[:id])
        @project.status = "completed";
        @project.save
        
        if Project.where(status: "unapproved_completed").count > 0
            flash[:success] = "Project '#{@project.name}' completion approved."
            redirect_to unapproved_completed_projects_index_path
        else
            flash[:success] = "Project '#{@project.name}' approved. All projects have been approved."
            redirect_to projects_path
        end
    end
    
    def unapprove_completed
        @project = Project.find(params[:id])
        #@project.status = "open"
        @project.status = "unapproved_completed"
        if @project.save
          flash[:success] = "Project '#{@project.name}' completion unapproved."
        end
        redirect_to projects_path
    end

    def join
        @project = Project.find(params[:id])
        redirect_to projects_path and return unless @project.approved
        redirect_to project_path(@project) and return if @project.completed?

        if @project.tamu_users.include? current_user
            return redirect_to project_path(@project), notice: "You've already joined this project"
        end

        @project.tamu_users << current_user
        flash[:success] =  "Successfully joined #{@project.name}!"
        redirect_to project_path(@project)
    end

    def drop
        @project = Project.find(params[:id])
        redirect_to projects_path and return unless @project.approved
        redirect_to project_path(@project) and return if @project.completed?

        if not @project.tamu_users.include? current_user
            return redirect_to project_path(@project), notice: "You're not working on this project"
        end

        @project.tamu_users.delete(current_user)
        flash[:success] =  "Successfully dropped #{@project.name}!"
        redirect_to project_path(@project)
    end
    
    private

    def agency_only
      unless current_user.is_a?(Agency)
          redirect_to root_path, :alert => "Access Denied"
      end
    end
    
    def owner_only
        project = Project.find(params[:id])
        unless current_user == project.agency
            redirect_to root_path, :alert => "Access denied."
        end
    end

    def tamu_user_or_owner_only
      project = Project.find(params[:id])
      unless current_user.is_a?(TamuUser) or project.agency == current_user
        redirect_to root_path, :alert => "Access denied."
      end
    end

    def list_projects(projects)
      sorted = sort_projects(projects, params[:sort], params[:reverse])
      Kaminari.paginate_array(sorted).page(params[:page]).per(5)
    end
end

