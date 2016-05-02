class AgenciesController < ApplicationController
    
    before_action :admin_only, :only=>[:unapproved_index, :unapprove, :approve]
    before_action :tamu_user_only, :only=>[:index]
    before_action :tamu_user_or_owner_only, :only=>[:show]
    
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
        if user_should_not_see? @agency
          redirect_to agencies_path
        end
    end

    def edit
        @agency = Agency.find params[:id]
    end

    def update
        @agency = Agency.find params[:id]
        if @agency.update_attributes(agency_params)
            flash[:success] = "# Profile was successfully updated."
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
            flash[:success] = "Agency '#{@agency.name}' approved."
            redirect_to unapproved_agencies_index_path
        else
            flash[:success] = "Agency '#{@agency.name}' approved. All agencies have been approved."
            redirect_to agencies_path
        end
    end
    
    def unapprove
        @agency = Agency.find(params[:id])
        @agency.approved = false;
        @agency.save
        flash[:success] = "Agency '#{@agency.name}' unapproved."
        redirect_to agencies_path
    end
    
    private

    def owner_only
        agency = Agency.find params[:id]
        unless current_user == agency
            redirect_to root_path, :alert => "Access denied."
        end
    end
    
    def tamu_user_or_owner_only
        agency = Agency.find(params[:id])
        unless current_user.is_a?(TamuUser) or agency == current_user
            redirect_to root_path, :alert => "Access denied."
        end
    end
    
end
