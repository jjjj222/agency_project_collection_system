class AgenciesController < ApplicationController
    
    before_action :admin_only, :only=>[:unapproved_index, :unapprove, :approve]
    before_action :tamu_user_only, :only=>[:index, :show]
    
    before_action :owner_only, :only=>[:edit, :update, :destroy]

    def agency_params
      params.require(:agency).permit(:name)
    end
    
    def index
        @agencies = Agency.where(approved: true)
    end
    
    def unapproved_index
        @agencies = Agency.where(approved: false)
    end
    
    def show
        @agency = Agency.find params[:id]
        if !@agency.approved and current_user.is_a?(TamuUser) and !current_user.admin?
          redirect_to agencies_path
        end
    end

    def edit
        @agency = Agency.find params[:id]
    end

    def update
        @agency = Agency.find params[:id]
        if @agency.update_attributes(agency_params)
            flash[:notice] = "# Profile was successfully updated."
            redirect_to agency_path
        else
          model_failed_flash @agency
          render action: "edit", id: @agency.id
        end
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
    
    # def new
    #     @agency = Agency.new
    # end
    
    # def create
    #     @agency = Agency.new params[:agency]
    #     # This was in an example model controller from a tutorial
    #     # Not sure if this is something we need yet?
        
    #     if @agency.save
    #         redirect_to :action => 'show', :id => @agency.id
    #     else
    #         render :action => 'new'
    #     end
    # end
    
    # def destroy
    #     @agency = Agency.find params[:id]
    #     @agency.destroy
    # end
    
    private

    def owner_only
        @agency = Agency.find params[:id]
        unless current_user == @agency
            redirect_to root_path, :alert => "Access denied."
        end
    end
    
    def tamu_user_only
      if params[:id]
        @agency = Agency.find(params[:id])
        unless current_user.is_a?(TamuUser) or @agency == current_user
          redirect_to root_path, :alert => "Access denied."
        end
      else 
        unless current_user.is_a?(TamuUser)
          redirect_to root_path, :alert => "Access denied."
        end
      end
    end
    
end
