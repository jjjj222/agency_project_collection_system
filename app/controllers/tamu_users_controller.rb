class TamuUsersController < ApplicationController
    
    before_action :owner_only, :only=>[:edit, :update, :destroy]
    before_action :tamu_user_only, :only=>[:index, :show]
    
    def tamu_user_params
      params.require(:tamu_user).permit(:name, :email)
    end

    def index
        # if !logged_in?
        #   flash[:notice] = 'Please log in'
        #   redirect_to login_path
        # end
        @tamu_users = TamuUser.all
    end
    
    def show
        @tamu_user = TamuUser.find params[:id]
    end
    
    # def new
    #     @tamu_user = TamuUser.new
    # end
    
    # def create
    #     @tamu_user = TamuUser.new params[:tamu_user]
    #     # This was in an example model controller from a tutorial
    #     # Not sure if this is something we need yet?
    # end
    
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
          redirect_to root_path, :alert => "Access denied."
        end
      else #index
        if not logged_in?
          cas_log_in
        elsif not current_user.is_a?(TamuUser)
          redirect_to root_path, :alert => "Access denied."
        end
      end
    end
    
end
