class TamuUsersController < ApplicationController
    
    def index
        @tamuUsers = TamuUser.find :all
    end
    
    def show
        @tamuUser = TamuUser.find params[:id]
    end
    
    def new
        @tamuUser = TamuUser.new
    end
    
    def create
        @tamuUser = TamuUser.new params[:tamuUser]
        # This was in an example model controller from a tutorial
        # Not sure if this is something we need yet?
        
        # if @tamuUser.save
        #     redirect_to :action => 'show', :id => @tamuUser.id
        # else
        #     render :action => 'new'
        # end
    end
    
    def destroy
        @tamuUser = TamuUser.find params[:id]
        @tamuUser.destroy
    end
    
    def edit
        @tamuUser = TamuUser.find params[:id]
    end
    
    def update
        @tamuUser = TamuUser.find params[:id]
        # This was in an example model controller from a tutorial
        # Not sure if this is something we need yet?
        
        # if @robot.update_attributes(params[:tamuUser])
        #     redirect_to :action => 'show', :id => @tamuUser.id
        # end
    end
    
end
