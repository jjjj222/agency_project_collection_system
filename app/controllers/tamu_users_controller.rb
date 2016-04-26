class TamuUsersController < ApplicationController
    include TamuUsersHelper
    include ProjectsHelper
    
    before_action :admin_only, :only=>[:make_admin, :unapproved_professor_index, :approve_professor, :unapprove_professor]
    before_action :owner_only, :only=>[:edit, :update, :destroy]
    prepend_before_action :tamu_user_only, :only=>[:index, :show]
    prepend_before_action :new_tamu_user_only, :only => [:new, :create]
    skip_before_action :require_login, :only => [:new, :create]
    
    def tamu_user_params
      params.require(:tamu_user).permit(:name, :email)
    end
    def create_tamu_user_params
      params.require(:tamu_user).permit(:name, :email, :role, :netid).merge(netid: session_netid)
    end

    def index
        @tamu_users = TamuUser.all
    end
    
    def unapproved_professor_index
        @tamu_users = TamuUser.where(role: "unapproved_professor")
    end
    
    def approve_professor
        @professor = TamuUser.find(params[:id])
        @professor.role = "professor";
        @professor.save
        if TamuUser.where(role: "unapproved_professor").count > 0
            flash[:notice] = "TamuUser '#{@professor.name}' approved as professor."
            redirect_to unapproved_professors_index_path
        else
            flash[:notice] = "TamuUser '#{@professor.name}' approved as professor. All professors have been approved."
            redirect_to tamu_users_path
        end
    end
    
    def unapprove_professor
        @agency = TamuUser.find(params[:id])
        @agency.role = "unapproved_professor";
        @agency.save
        flash[:notice] = "Tamu User '#{@agency.name}' unapproved as professor."
        redirect_to tamu_users_path
    end
    
    def show
        @tamu_user = TamuUser.find params[:id]
        @projects = @tamu_user.projects
        @projects = sort_projects(@projects, params[:sort])
        #sort_projects()
    end
    
    def new
         @tamu_user = new_tamu_user_skeleton
    end
    
    def create
        #TODO: stop creating as faculty for now?
        @tamu_user = TamuUser.new create_tamu_user_params
        if @tamu_user.save
            log_in(@tamu_user)
            flash[:success] = "Profile for #{@tamu_user.name} was successfully created!"
            redirect_to tamu_user_path(@tamu_user)
        else
            model_failed_flash @tamu_user
            render action: "new"
        end
    end
    
    def destroy
        @tamu_user = TamuUser.find params[:id]
        @tamu_user.destroy
        flash[:success] = "TAMU User '#{@tamu_user.name}' deleted."
        redirect_to tamu_users_path
    end
    
    def edit
        @tamu_user = TamuUser.find params[:id]
    end
    
    def update
        @tamu_user = TamuUser.find params[:id]
        if @tamu_user.update_attributes(tamu_user_params)
            flash[:success] = "# Profile was successfully updated."
            redirect_to tamu_user_path
        else
            model_failed_flash @tamu_user
            render action: "edit", id: @tamu_user.id
        end
    end

    def make_admin
        @tamu_user = TamuUser.find params[:id]
        @tamu_user.admin = true
        @tamu_user.save
        flash[:success] = "Successfully made #{@tamu_user.name} into an admin"
        redirect_to tamu_users_path
    end
    
    private

    def owner_only
        @tamu_user = TamuUser.find params[:id]
        unless current_user == @tamu_user
            redirect_to root_path, :alert => "Access denied."
        end
    end
    
    #will need to modify once we can connect agencies to tamu user to allow agencies to see show if they are connected with that specific tamu user
    def tamu_user_only
      if params[:id] #show
        @tamu_user = TamuUser.find(params[:id])
        unless current_user.is_a?(TamuUser) or @tamu_user == current_user
          return redirect_to root_path, :alert => "Access denied."
        end
      else #index
        if not logged_in?
          cas_log_in
        elsif not current_user.is_a?(TamuUser)
          return redirect_to root_path, :alert => "Access denied."
        end
      end
    end

    def new_tamu_user_only
      if logged_in? or (not cas_logged_in?)
          return redirect_to root_path, :alert => "Access denied."
      end
    end
end
