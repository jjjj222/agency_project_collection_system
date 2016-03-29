class TamuUsersController < ApplicationController
    
    def index
        @tamu_users = TamuUser.all
    end
    
    def show
        @tamu_user = TamuUser.find params[:id]
    end
    
    def new
        @tamu_user = TamuUser.new
    end
    
    def create
        @tamu_user = TamuUser.new params[:tamu_user]
        # This was in an example model controller from a tutorial
        # Not sure if this is something we need yet?
        
        # if @tamu_user.save
        #     redirect_to :action => 'show', :id => @tamu_user.id
        # else
        #     render :action => 'new'
        # end
    end
    
    def destroy
        @tamu_user = TamuUser.find params[:id]
        @tamu_user.destroy
    end
    
    def edit
        @tamu_user = TamuUser.find params[:id]
    end
    
    def update
        @tamu_user = TamuUser.find params[:id]
        # This was in an example model controller from a tutorial
        # Not sure if this is something we need yet?
        
        # if @robot.update_attributes(params[:tamu_user])
        #     redirect_to :action => 'show', :id => @tamu_user.id
        # end
    end
    
end
