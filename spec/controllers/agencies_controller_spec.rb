require 'rails_helper'

RSpec.describe AgenciesController, type: :controller do
    
    describe "GET #index" do
        it "populates an array of agencies" do
            agency = FactoryGirl.create(:agency, :default, :approved)
            get :index
            assigns(:agencies).should eq([agency])
        end
        
        it "renders the :index view" do
            get :index
            response.should render_template :index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested agency to @agency" do
            agency = FactoryGirl.create(:agency, :default)
            get :show, id: agency
            assigns(:agency).should eq(agency)
        end
        
        
        it "it renders the :show view" do
            get :show, id: FactoryGirl.create(:agency, :default)
            response.should render_template :show
        end
    end
    
end
