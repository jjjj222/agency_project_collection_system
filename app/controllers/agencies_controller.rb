class AgenciesController < ApplicationController
    
    def index
        @agencies = Agency.all
    end
    
    def show
        @agency = Agency.find params[:id]
    end
    
    #def new
    #    @agency = Agency.new
    #end
    
    #def create
    #    @agency = Agency.new params[:agency]
        # This was in an example model controller from a tutorial
        # Not sure if this is something we need yet?
        
        # if @agency.save
        #     redirect_to :action => 'show', :id => @agency.id
        # else
        #     render :action => 'new'
        # end
    #end
    
    #def destroy
    #    @agency = Agency.find params[:id]
    #    @agency.destroy
    #end
    
    #def edit
    #    @agency = Agency.find params[:id]
    #end
    
    #def update
    #    @agency = Agency.find params[:id]
        # This was in an example model controller from a tutorial
        # Not sure if this is something we need yet?
        
        # if @robot.update_attributes(params[:agency])
        #     redirect_to :action => 'show', :id => @agency.id
        # end
    #end
    
end
