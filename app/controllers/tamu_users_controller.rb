class TamuUsersController < ApplicationController
    include TamuUsersHelper
    include ProjectsHelper
    
    before_action :admin_only, :only=>[:make_admin, :unapproved_professor_index, :approve_professor, :unapprove_professor]
    before_action :owner_only, :only=>[:edit, :update, :destroy]
    before_action :tamu_user_only, :only=>[:index]
    before_action :tamu_user_or_related, :only => [:show]
    before_action :new_tamu_user_only, :only => [:new, :create]
    before_action :master_admin_only, :only => [:demote_admin]
    skip_before_action :require_login, :only => [:new, :create]
    
    def tamu_user_params
      params.require(:tamu_user).permit(:name, :email, :role, :description)
    end
    def create_tamu_user_params
      params.require(:tamu_user).permit(:name, :email, :role, :netid).merge(netid: session_netid)
    end

    def index
        @tamu_users = list_users TamuUser.all
    end
    
    def unapproved_professor_index
        @tamu_users = list_users TamuUser.where(role: "unapproved_professor")
    end
    
    def approve_professor
        @professor = TamuUser.find(params[:id])
        @professor.role = "professor";
        @professor.save
        if TamuUser.where(role: "unapproved_professor").count > 0
            flash[:success] = "TamuUser '#{@professor.name}' approved as professor."
            redirect_to unapproved_professors_index_path
        else
            flash[:success] = "TamuUser '#{@professor.name}' approved as professor. All professors have been approved."
            redirect_to tamu_users_path
        end
    end
    
    def unapprove_professor
        @professor = TamuUser.find(params[:id])
        @professor.role = "unapproved_professor";
        @professor.save
        flash[:success] = "Tamu User '#{@professor.name}' unapproved as professor."
        redirect_to tamu_users_path
    end
    
    def block_user
        @tamu_user = TamuUser.find(params[:id])
        if !@tamu_user.admin?
            @tamu_user.blocked = true;
            @tamu_user.save
        end
        redirect_to tamu_user_path(@tamu_user)
    end
    
    def unblock_user
        @tamu_user = TamuUser.find(params[:id])
        @tamu_user.blocked = false;
        @tamu_user.save
        redirect_to tamu_user_path(@tamu_user)
    end
    
    def show
        @tamu_user = TamuUser.find params[:id]
        @projects = @tamu_user.projects
        @projects = sort_projects(@projects, params[:sort], params[:reverse])
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
	redirect_to tamu_users_path, notice: "You can't delete master admins" and return if @tamu_user.master_admin?
        @tamu_user.destroy
        flash[:success] = "TAMU User '#{@tamu_user.name}' deleted."
        redirect_to tamu_users_path
    end
    
    def edit
        @tamu_user = TamuUser.find params[:id]
    end
    
    def update
        @tamu_user = TamuUser.find params[:id]
        new_params = tamu_user_params
        if @tamu_user.professor?
          new_params[:role] = "professor" if new_params[:role] == "unapproved_professor"
        else
          new_params[:role] = "unapproved_professor" if new_params[:role] == "professor"
        end


        if @tamu_user.update_attributes new_params
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

    def demote_admin
        @tamu_user = TamuUser.find params[:id]
        if @tamu_user == current_user
          redirect_to tamu_users_path, notice: "You can't demote yourself" and return
        end
        @tamu_user.master_admin = false
        @tamu_user.admin = false
        @tamu_user.save
        flash[:success] = "#{@tamu_user.name} no longer an admin"
        redirect_to tamu_users_path
    end
    
    private

    def owner_only
        tamu_user = TamuUser.find params[:id]
        unless current_user == tamu_user
            redirect_to root_path, :alert => "Access denied."
        end
    end

    def tamu_user_or_related
        unless current_user.is_a?(TamuUser) ||
          (current_user.is_a?(Agency) && current_user.related_to_tamu_user?(params[:id]))
            redirect_to root_path, :alert => "Access denied."
        end
    end

    def new_tamu_user_only
      if logged_in? or (not cas_logged_in?)
          return redirect_to root_path, :alert => "Access denied."
      end
    end

    def list_users(list)
      list.order(:name).page(params[:page]).per(9)
    end
end
