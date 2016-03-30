class TamuUsersController < ApplicationController
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
    end
    
    def edit
        @tamu_user = TamuUser.find params[:id]
    end
    
    def update
        @tamu_user = TamuUser.find params[:id]
        if @tamu_user.update_attributes(tamu_user_params)
            flash[:notice] = "# Profile was successfully updated."
            redirect_to :action => 'edit', id: @tamu_user.id
        else
          if @tamu_user.errors.any?
            flash[:notice] = @tamu_user.errors.full_messages.join("\n")
          else
            flash[:notice] = "Failed"
          end
            render action: "edit", id: @tamu_user.id
        end
    end
    
end
