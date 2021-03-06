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
        
        it "redirects to root path if not tamu_user" do
          controller.log_out
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
          get :index
          expect(response).to redirect_to root_path
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
        
        it "redirects to root path if not admin" do
            not_an_admin = FactoryGirl.create(:tamu_user, :default, :not_admin)
            controller.log_in(not_an_admin)
            get :unapproved_index
            expect(response).to redirect_to root_path
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
        
        it "it renders :agencies if not admin trying to view unapproved agency" do
            controller.log_out
            @tamu_user_not_admin = FactoryGirl.create(:tamu_user, :default, :not_admin)
            controller.log_in(@tamu_user_not_admin)
            get :show, id: FactoryGirl.create(:agency, :default, :unapproved)
            expect(response).to redirect_to agencies_path
        end
        
        it "redirects to root path if not tamu_user and is not the current agency" do
          controller.log_out
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
          get :show, id: FactoryGirl.create(:agency, :default)
          expect(response).to redirect_to root_path
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
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :approve, id: @agency
            expect(response).to redirect_to root_path
      end
      
    end
    
    describe 'POST unapprove' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        @project = FactoryGirl.create(:project, :default, :approved, agency: @agency)
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

      it "unapprove the projects of the agency as well" do
        post :unapprove, id: @agency
        @agency.reload
        @project.reload
        expect(@project.approved).to eq(false)
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
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :unapprove, id: @agency
            expect(response).to redirect_to root_path
      end
      
    end

    describe "GET #edit" do
        it "assigns the requested agency to @agency" do
            agency = FactoryGirl.create(:agency, :default)
            controller.log_in(agency)
            get :edit, id: agency
            expect(assigns(:agency)).to eq(agency)
        end
        it "it renders the :edit view" do
            agency = FactoryGirl.create(:agency, :default)
            controller.log_in(agency)
            get :edit, id: agency
            expect(response).to render_template :edit
        end 
        
        it "it renders the root path if not current agency" do
            agency = FactoryGirl.create(:agency, :default)
            controller.log_in(agency)
            get :edit, id: FactoryGirl.create(:agency, :other)
            expect(response).to redirect_to root_path
        end 
    end
    
    describe 'PUT update' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default)
        controller.log_in(@agency)
      end
  
      context "valid attributes" do
        context "everything goes well" do
          it "located the requested @agency" do
            put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default)
            expect(assigns(:agency)).to eq(@agency)
          end

          it "changes @agency's attributes, but not email" do
            put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :updated)
            @agency.reload
            expect(@agency.name).to eq("New Agency")
            expect(@agency.email).to eq("agency@nonprofit.org")
          end

          it "redirects to the updated agency" do
            put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :default)
            expect(response).to redirect_to @agency
          end
        end
        context "update fails" do
          before :each do
            expect_any_instance_of(Agency).to receive(:update_attributes).and_return(nil)
          end

          it "does not change @agency's attributes" do
            put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :invalid)
            @agency.reload
            expect(@agency.name).to eq("Test Agency")
            expect(@agency.email).to eq("agency@nonprofit.org")
          end

          it "re-renders the edit method" do
            put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :invalid)
            expect(response).to render_template :edit
          end
        end
        
      end
  
      context "invalid attributes" do
        it "locates the requested @agency" do
          put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :invalid)
          expect(assigns(:agency)).to eq(@agency)
        end
    
        it "does not change @agency's attributes" do
          put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :invalid)
          @agency.reload
            expect(@agency.name).to eq("Test Agency")
            expect(@agency.email).to eq("agency@nonprofit.org")
        end
    
        it "re-renders the edit method" do
          put :update, id: @agency, agency: FactoryGirl.attributes_for(:agency, :invalid)
          expect(response).to render_template :edit
        end
      end
    end
end
