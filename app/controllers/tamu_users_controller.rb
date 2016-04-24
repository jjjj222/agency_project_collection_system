class TamuUsersController < ApplicationController
    include TamuUsersHelper
    
    before_action :admin_only, :only=>[:make_admin]
    before_action :owner_only, :only=>[:edit, :update, :destroy]
    prepend_before_action :tamu_user_only, :only=>[:index, :show]
    prepend_before_action :new_tamu_user_only, :only => [:new, :create]
    skip_before_action :require_login, :only => [:new, :create]
    skip_before_action :verify_authenticity_token, :only => [:make_admin]
    
    def tamu_user_params
      params.require(:tamu_user).permit(:name, :email)
    end
    def create_tamu_user_params
      params.require(:tamu_user).permit(:name, :email, :role, :netid).merge(netid: session_netid)
    end

    def index
        @tamu_users = TamuUser.all
    end
    
    def show
        @tamu_user = TamuUser.find params[:id]
    end
    
    def new
         @tamu_user = new_tamu_user_skeleton
    end
    
    def create
        #TODO: stop creating as faculty for now?
        @tamu_user = TamuUser.new create_tamu_user_params
        if @tamu_user.save
            log_in(@tamu_user)
            flash[:notice] = "Profile for #{@tamu_user.name} was successfully created!"
            redirect_to tamu_user_path(@tamu_user)
        else
            model_failed_flash @tamu_user
            render action: "new"
        end
    end
    
    def destroy
        @tamu_user = TamuUser.find params[:id]
        @tamu_user.destroy
        flash[:notice] = "TAMU User '#{@tamu_user.name}' deleted."
        redirect_to tamu_users_path
    end
    
    def edit
        @tamu_user = TamuUser.find params[:id]
    end
    
    def update
        @tamu_user = TamuUser.find params[:id]
        if @tamu_user.update_attributes(tamu_user_params)
            flash[:notice] = "# Profile was successfully updated."
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
        redirect_to tamu_users_path, notice: "Successfully made #{@tamu_user.name} into an admin"
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
