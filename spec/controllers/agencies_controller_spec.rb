require 'rails_helper'

RSpec.describe AgenciesController, type: :controller do
    
    describe "GET #index" do
        it "populates an array of agencies" do
            agency = FactoryGirl.create(:agency, :default, :approved)
            
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            
            controller.log_in(tamu_user)
            
            get :index
            expect(assigns(:agencies)).to eq([agency])
        end
        
        it "renders the :index view" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(tamu_user)
            session[:user_id] = tamu_user.id
            session[:user_type] = "TamuUser"

            get :index
            expect(response).to render_template :index
        end
    end
    
    describe "GET #unapproved index" do
        it "populates an array of agencies" do
            admin = FactoryGirl.create(:tamu_user, :default, :admin)
            controller.log_in(admin)
            agency = FactoryGirl.create(:agency, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:agencies)).to eq([agency])
        end
        
        it "renders the :index view" do
            admin = FactoryGirl.create(:tamu_user, :default, :admin)
            controller.log_in(admin)
            get :unapproved_index
            expect(response).to render_template :unapproved_index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested agency to @agency" do
            agency = FactoryGirl.create(:agency, :default)
            controller.log_in(agency)
            get :show, id: agency
            expect(assigns(:agency)).to eq(agency)
        end
        
        
        it "it renders the :show view" do
            agency = FactoryGirl.create(:agency, :default)
            controller.log_in(agency)
            get :show, id: agency.id
            expect(response).to render_template :show
        end
    end
    
    describe 'POST approve' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :unapproved)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @agency" do
        post :approve, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default, :unapproved)
        expect(assigns(:agency)).to eq(@agency)
      end

      it "changes @agency's approved field" do
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @agency.reload
        expect(@agency.approved).to eq(true)
      end

      it "redirects to the approved agencies if there is no unapproved agencies left" do
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to agencies_path
      end
      
      it "redirects to the unapproved agencies if there are unapproved agencies left" do
        FactoryGirl.create(:agency, :default, :unapproved)
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to unapproved_agencies_index_path
      end
    end
    
    describe 'POST unapprove' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @agency" do
        post :unapprove, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        expect(assigns(:agency)).to eq(@agency)
      end

      it "changes @agency's approved field" do
        post :unapprove, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @agency.reload
        expect(@agency.approved).to eq(false)
      end

      it "redirects to the approved agencies" do
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to agencies_path
      end
    end
    
end
