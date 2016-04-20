require 'rails_helper'

RSpec.describe AgenciesController, type: :controller do
    
    describe "GET #index" do
        it "if logged in as a tamu user, it populates an array of agencies" do
            agency = FactoryGirl.create(:agency, :default, :approved)
            
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            
            controller.log_in(tamu_user)
            
            get :index
            expect(assigns(:agencies)).to eq([agency])
        end
        
        it "if logged in as a tamu user, it renders the :index view" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            controller.log_in(tamu_user)
            session[:user_id] = tamu_user.id
            session[:user_type] = "TamuUser"

            get :index
            expect(response).to render_template :index
        end
        
        it "if not in as a tamu user, it populates an array of agencies" do
            get :index
            expect(assigns(:agencies)).to eq(nil)
        end
        
        it "if logged in as a tamu user, it renders the :index view" do
            get :index
            expect(response).to_not render_template :edit
        end
    end
    
    describe "GET #unapproved index" do
        it "populates an array of agencies if logged in as admin" do
            admin = FactoryGirl.create(:tamu_user, :default, :admin)
            controller.log_in(admin)
            agency = FactoryGirl.create(:agency, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:agencies)).to eq([agency])
        end
        
        it "does not populate an array of agencies if not logged in as admin" do
            agency = FactoryGirl.create(:agency, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:agencies)).to_not eq([agency])
        end
        
        it "renders the unapproved index view if logged in as admin" do
            admin = FactoryGirl.create(:tamu_user, :default, :admin)
            controller.log_in(admin)
            get :unapproved_index
            expect(response).to render_template :unapproved_index
        end
        
        it "does not render the index view if not logged in as admin" do
            get :unapproved_index
            expect(response).to_not render_template :unapproved_index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested agency to @agency if logged in as the agency" do
            agency = FactoryGirl.create(:agency, :default)
            controller.log_in(agency)
            get :show, id: agency
            expect(assigns(:agency)).to eq(agency)
        end
        
        it "does not assign the requested agency to @agency if not logged in as the agency" do
            agency = FactoryGirl.create(:agency, :default)
            get :show, id: agency
            expect(assigns(:agency)).to_not eq(agency)
        end
        
        
        it "it renders the :show view if logged in as the agency" do
            agency = FactoryGirl.create(:agency, :default)
            controller.log_in(agency)
            get :show, id: agency.id
            expect(response).to render_template :show
        end
        
        it "it does not render the :show view if not logged in as the agency" do
            agency = FactoryGirl.create(:agency, :default)
            get :show, id: agency.id
            expect(response).to_not render_template :show
        end
    end
    
    describe 'POST approve' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :unapproved)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @agency if logged in as admin" do
        post :approve, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default, :unapproved)
        expect(assigns(:agency)).to eq(@agency)
      end

      it "changes @agency's approved field if logged in as admin" do
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @agency.reload
        expect(@agency.approved).to eq(true)
      end

      it "redirects to the approved agencies if there is no unapproved agencies left if logged in as admin" do
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to agencies_path
      end
      
      it "redirects to the unapproved agencies if there are unapproved agencies left if logged in as admin" do
        FactoryGirl.create(:agency, :default, :unapproved)
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to unapproved_agencies_index_path
      end
      
      
      it "should not locate the requested @agency if not logged in" do
        controller.log_out
        post :approve, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default, :unapproved)
        expect(assigns(:agency)).to_not eq(@agency)
      end

      it "changes @agency's approved field if not logged in" do
        controller.log_out
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @agency.reload
        expect(@agency.approved).to_not eq(true)
      end

      it "redirects to the approved agencies if there is no unapproved agencies left if not logged in" do
        controller.log_out
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to_not redirect_to agencies_path
      end
      
      it "redirects to the unapproved agencies if there are unapproved agencies left if not logged in" do
        controller.log_out
        FactoryGirl.create(:agency, :default, :unapproved)
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to_not redirect_to unapproved_agencies_index_path
      end
    end
    
    describe 'POST unapprove' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
      end

      it "located the requested @agency if logged in as admin" do
        post :unapprove, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        expect(assigns(:agency)).to eq(@agency)
      end

      it "changes @agency's approved field if logged in as admin" do
        post :unapprove, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @agency.reload
        expect(@agency.approved).to eq(false)
      end

      it "redirects to the approved agencies if logged in as admin" do
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to redirect_to agencies_path
      end
      
      it "should not locate the requested @agency if logged not in as admin" do
        controller.log_out
        post :unapprove, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        expect(assigns(:agency)).to_not eq(@agency)
      end

      it "should not change @agency's approved field if not logged in as admin" do
        controller.log_out
        post :unapprove, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default, :approved)
        @agency.reload
        expect(@agency.approved).to_not eq(false)
      end

      it "should not redirect to the approved agencies if not logged in as admin" do
        controller.log_out
        post :approve, id: @agency#, agency: FactoryGirl.attributes_for(:agency, :default)
        expect(response).to_not redirect_to agencies_path
      end
    end
    
end
