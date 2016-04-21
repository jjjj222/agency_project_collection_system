require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    describe "GET #index" do
      
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in(@tamu_user)
        end
      
        it "populates an array of projects if logged in as tamu user" do
            project = FactoryGirl.create(:project, :default, :approved)
            get :index
            expect(assigns(:projects)).to eq([project])
        end
        
        it "renders the :index view if logged in as tamu user" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            session[:user_id] = tamu_user.id
            session[:user_type] = "TamuUser"

            get :index
            expect(response).to render_template :index
        end
        
        it "populates an array of projects if logged in" do
            controller.log_out
            project = FactoryGirl.create(:project, :default, :approved)
            get :index
            expect(assigns(:projects)).to_not eq([project])
        end
        
        it "renders the :index view if logged in" do
            controller.log_out
            tamu_user = FactoryGirl.create(:tamu_user, :default)

            get :index
            expect(response).to_not render_template :index
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
        
        before :each do
          @admin = FactoryGirl.create(:tamu_user, :default, :admin)
          controller.log_in(@admin)
        end
      
        it "populates an array of projects if logged in as admin" do
            project = FactoryGirl.create(:project, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:projects)).to eq([project])
        end
        
        it "renders the unapproved index view if logged in as admin" do
            get :unapproved_index
            expect(response).to render_template :unapproved_index
        end
        
        it "populates an array of projects if not logged in as admin" do
            controller.log_out
            project = FactoryGirl.create(:project, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:projects)).to_not eq([project])
        end
        
        it "renders the unapproved index view if not logged in as admin" do
            controller.log_out
            get :unapproved_index
            expect(response).to_not render_template :unapproved_index
        end
        
        it "redirects to root path if not admin" do
            controller.current_user.admin = false
            get :unapproved_index
            expect(response).to redirect_to root_path
        end
        
    end
    
    describe "GET #show" do
      
        before :each do
          @tamu_user = FactoryGirl.create(:tamu_user, :default)
          controller.log_in(@tamu_user)
        end
      
        it "assigns the requested project to @project if logged in as a tamu user" do
            project = FactoryGirl.create(:project, :default)
            get :show, id: project
            expect(assigns(:project)).to eq(project)
        end
        
        
        it "it renders the :show view if logged in as tamu user" do
            get :show, id: FactoryGirl.create(:project, :default)
            expect(response).to render_template :show
        end
        
        it "does not assign the requested project to @project if not logged in" do
            controller.log_out
            project = FactoryGirl.create(:project, :default)
            get :show, id: project
            expect(assigns(:project)).to_not eq(project)
        end
        
        
        it "it does not render the :show view if not logged in" do
            controller.log_out
            get :show, id: FactoryGirl.create(:project, :default)
            expect(response).to_not render_template :show
        end
        
        it "it renders :projects if not admin trying to view unapproved project" do
            controller.log_out
            @tamu_user_not_admin = FactoryGirl.create(:tamu_user, :default, :not_admin)
            controller.log_in(@tamu_user_not_admin)
            get :show, id: FactoryGirl.create(:project, :default)
            expect(response).to redirect_to projects_path
        end
        
        it "redirects to root path if not tamu_user and does not own projects" do
          controller.log_out
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
          get :show, id: FactoryGirl.create(:project, :default)
          expect(response).to redirect_to root_path
        end
        
    end
    
    describe "GET #edit" do
      
        before :each do
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
        end
      
        it "assigns the requested project to @project if logged in as the owning agency" do
            project = FactoryGirl.create(:project, :default)
            get :edit, id: project
            expect(assigns(:project)).to eq(project)
        end


        it "it renders the :edit view if logged in as the owning agency" do
            @project = FactoryGirl.create(:project, :default, :agency => @agency)
            get :edit, id: @project
            expect(response).to render_template :edit
        end
        
        it "does not assign the requested project to @project if not logged in as the owning agency" do
            controller.log_out
            project = FactoryGirl.create(:project, :default)
            get :edit, id: project
            expect(assigns(:project)).to_not eq(project)
        end


        it "it does not render the :edit view if not logged in as the owning agency" do
            controller.log_out
            @project = FactoryGirl.create(:project, :default, :agency => @agency)
            get :edit, id: @project
            expect(response).to_not render_template :edit
        end
    end

    describe "GET #new" do
      
        before :each do
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
        end
      
        it "makes a new project if logged in as an agency" do
            get :new
            expect(assigns(:project)).to be_a_new(Project)
        end

        it "it renders the :new view if logged in as an agency" do
            get :new
            expect(response).to render_template :new
        end
        
        it "does not create a new project if not logged in as an agency" do
            controller.log_out
            get :new
            expect(assigns(:project)).to_not be_a_new(Project)
        end

        it "it does not render the :new view if not logged in as an agency" do
            controller.log_out
            get :new
            expect(response).to_not render_template :new
        end
    end
    
    describe "POST create" do
      
      before :each do
          @agency = FactoryGirl.create(:agency, :default, :approved)
          controller.log_in(@agency)
      end
      
      context "with valid attributes and logged in as agency" do
        it "creates a new project" do
          expect{
            post :create, project: FactoryGirl.attributes_for(:project, :default)
          }.to change(Project,:count).by(1)
        end
        
        it "redirects to the new project" do
          post :create, project: FactoryGirl.attributes_for(:project, :default)
          expect(response).to redirect_to Project.last
        end
      end
      
       context "with invalid attributes" do
        it "does not save the new contact" do
          expect{
            post :create, project: FactoryGirl.attributes_for(:project, :invalid)
          }.to_not change(Project,:count)
        end
        
        it "re-renders the new method" do
          post :create, project: FactoryGirl.attributes_for(:project, :invalid)
        end
      end
      
      context "with valid attributes but not logged in" do
        it "creates a new project" do
          controller.log_out
          expect{
            post :create, project: FactoryGirl.attributes_for(:project, :default)
          }.to change(Project,:count).by(0)
        end
        
        it "redirects to the new project" do
          controller.log_out
          post :create, project: FactoryGirl.attributes_for(:project, :default)
          expect(response).to_not redirect_to Project.last
        end
      end
    end
    
    describe 'PUT update' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        controller.log_in(@agency)
        @project = FactoryGirl.create(:project, :default, :agency => @agency)
      end
  
      context "valid attributes and logged in as agency" do
        it "located the requested @project" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
          expect(assigns(:project)).to eq(@project)
        end
  
        context  "everything goes well" do
          it "changes @project's attributes" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :updated)
            @project.reload
            expect(@project.name).to eq("Test Project updated")
            expect(@project.description).to eq("This is the test project description updated")
            expect(@project.status).to eq("completed")
            expect(@project.tags).to eq(["updated"])
          end

          it "redirects to the updated project" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
            expect(response).to redirect_to @project
          end
        end
        context  "update fails" do
          before :each do
            expect_any_instance_of(Project).to receive(:update_attributes).and_return(nil)
          end

          it "does not change @project's attributes" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
            @project.reload
            expect(@project.name).to eq("Test Project")
            expect(@project.description).to eq("This is the test project description")
            expect(@project.status).to eq("open")
            expect(@project.tags).to eq([""])
          end
          it "re-renders the edit method" do
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
            expect(response).to render_template :edit
          end

        end

      end
  
      context "invalid attributes" do
        it "locates the requested @project" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          expect(assigns(:project)).to eq(@project)
        end
    
        it "does not change @project's attributes" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          @project.reload
          expect(@project.name).to eq("Test Project")
          expect(@project.description).to eq("This is the test project description")
          expect(@project.status).to eq("open")
          expect(@project.tags).to eq([""])
        end
    
        it "re-renders the edit method" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          expect(response).to render_template :edit
        end
      end
      
      context "valid attributes and not logged in as agency" do
        it "located the requested @project" do
          controller.log_out
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
          expect(assigns(:project)).to_not eq(@project)
        end
  
        context  "everything goes well" do
          it "changes @project's attributes" do
            controller.log_out
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :updated)
            @project.reload
            expect(@project.name).to_not eq("Test Project updated")
            expect(@project.description).to_not eq("This is the test project description updated")
            expect(@project.status).to_not eq("completed")
            expect(@project.tags).to_not eq(["updated"])
          end

          it "redirects to the updated project" do
            controller.log_out
            put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
            expect(response).to_not redirect_to @project
          end
        end
      end
    end
    
    describe 'POST approve' do
      before :each do
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
        @project = FactoryGirl.create(:project, :default, :unapproved)
      end

      it "located the requested @project if logged in as admin" do
        post :approve, id: @project, project: FactoryGirl.attributes_for(:project, :default, :unapproved)
        expect(assigns(:project)).to eq(@project)
      end

      it "changes @project's approved field if logged in as admin" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to eq(true)
      end
      
      it "does not locate the requested @project if not logged in" do
        controller.log_out
        post :approve, id: @project, project: FactoryGirl.attributes_for(:project, :default, :unapproved)
        expect(assigns(:project)).to_not eq(@project)
      end

      it "does not change @project's approved field if not logged in" do
        controller.log_out
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to_not eq(true)
      end

      it "redirects to the approved projects if there is no unapproved projects left if logged in as admin" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to projects_path
      end
      
      it "redirects to the unapproved projects if there are unapproved projects left if logged in as admin" do
        FactoryGirl.create(:project, :default, :unapproved)
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to unapproved_projects_index_path
      end
      
      it "does not redirect to the approved projects if there is no unapproved projects left if not logged in" do
        controller.log_out
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to_not redirect_to projects_path
      end
      
      it "does not redirect to the unapproved projects if there are unapproved projects left if not logged in" do
        controller.log_out
        FactoryGirl.create(:project, :default, :unapproved)
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to_not redirect_to unapproved_projects_index_path
      end
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :approve, id: @project
            expect(response).to redirect_to root_path
      end
      
    end
    
    describe 'POST unapprove' do
      before :each do
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
        controller.log_in(@admin)
        @project = FactoryGirl.create(:project, :default, :approved)
      end

      it "located the requested @project if logged in" do
        post :unapprove, id: @project, project: FactoryGirl.attributes_for(:project, :default, :approved)
        expect(assigns(:project)).to eq(@project)
      end

      it "changes @project's approved field if logged in" do
        post :unapprove, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to eq(false)
      end

      it "redirects to the approved projects if logged in" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to projects_path
      end
      
      it "is not located the requested @project if not logged in" do
        controller.log_out
        post :unapprove, id: @project, project: FactoryGirl.attributes_for(:project, :default, :approved)
        expect(assigns(:project)).to_not eq(@project)
      end

      it "does not change @project's approved field if not logged in" do
        controller.log_out
        post :unapprove, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to_not eq(false)
      end

      it "does not redirect to the approved projects if not logged in" do
        controller.log_out
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to_not redirect_to projects_path
      end
      
      it "redirects to root path if not admin" do
            controller.current_user.admin = false
            post :unapprove, id: @project
            expect(response).to redirect_to root_path
      end
      
    end
    
    describe 'DELETE destroy' do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, :approved)
        controller.log_in(@agency)
        @project = FactoryGirl.create(:project, :default, :agency => @agency)
      end
      
      it "deletes the project if logged in as agency" do
        expect{
          delete :destroy, id: @project
        }.to change(Project,:count).by(-1)
      end
        
      it "redirects to project#index if logged in as agency" do
        delete :destroy, id: @project
        expect(response).to redirect_to projects_path
      end
      
      it "does not delete the project if not logged in as agency" do
        controller.log_out
        expect{
          delete :destroy, id: @project
        }.to change(Project,:count).by(0)
      end
        
      it "does not redirect to project#index if not logged in as agency" do
        controller.log_out
        delete :destroy, id: @project
        expect(response).to_not redirect_to projects_path
      end
      
      it "redirects to root path if not agency" do
        controller.log_out
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        controller.log_in(@tamu_user)
        delete :destroy, id: @project
        expect(response).to redirect_to root_path
      end
      
    end
end
