class AgenciesController < ApplicationController
    
    before_action :admin_only, :only=>[:unapproved_index, :unapprove, :approve]
    
    def index
        @agencies = Agency.where(approved: true)
    end
    
    def unapproved_index
        @agencies = Agency.where(approved: false)
    end
    
    def show
        @agency = Agency.find params[:id]
    end
    
    def approve
        @agency = Agency.find(params[:id])
        @agency.approved = true;
        @agency.save
        if Agency.where(approved: false).count > 0
            flash[:notice] = "Agency '#{@agency.name}' approved."
            redirect_to unapproved_agencies_index_path
        else
            flash[:notice] = "Agency '#{@agency.name}' approved. All agencies have been approved."
            redirect_to agencies_path
        end
    end
    
    def unapprove
        @agency = Agency.find(params[:id])
        @agency.approved = false;
        @agency.save
        flash[:notice] = "Agency '#{@agency.name}' unapproved."
        redirect_to agencies_path
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
    
    private

    def admin_only
      unless current_user.admin?
        redirect_to root_path, :alert => "Access denied."
      end
    end
    
end
