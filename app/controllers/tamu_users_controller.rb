class TamuUsersController < ApplicationController
    
    before_action :owner_only, :only=>[:edit, :update, :destroy]
    
    def tamu_user_params
      params.require(:tamu_user).permit(:name, :email)
    end

    def index
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
            # redirect_to :action => 'edit', id: @tamu_user.id
        else
          if @tamu_user.errors.any?
            flash[:notice] = @tamu_user.errors.full_messages.join("<br>")
          else
            flash[:notice] = "Failed"
          end
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
    
end
