require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    
    describe "GET #index" do
        it "populates an array of projects" do
            project = FactoryGirl.create(:project, :default, :approved)
            get :index
            expect(assigns(:projects)).to eq([project])
        end
        
        it "renders the :index view" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            session[:user_id] = tamu_user.id
            session[:user_type] = "TamuUser"

            get :index
            expect(response).to render_template :index
        end
    end
    
    describe "GET #unapproved index" do
        it "populates an array of projects" do
            project = FactoryGirl.create(:project, :default, :unapproved)
            get :unapproved_index
            expect(assigns(:projects)).to eq([project])
        end
        
        it "renders the :index view" do
            get :unapproved_index
            expect(response).to render_template :unapproved_index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested tamu user to @tamu_user" do
            project = FactoryGirl.create(:project, :default)
            get :show, id: project
            expect(assigns(:project)).to eq(project)
        end
        
        
        it "it renders the :show view" do
            get :show, id: FactoryGirl.create(:project, :default)
            expect(response).to render_template :show
        end
    end
    
    describe "POST create" do
      context "with valid attributes" do
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
    end
    
    describe 'PUT update' do
      before :each do
        @project = FactoryGirl.create(:project, :default)
      end
  
      context "valid attributes" do
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
    end
    
    describe 'POST approve' do
      before :each do
        @project = FactoryGirl.create(:project, :default, :unapproved)
      end

      it "located the requested @project" do
        post :approve, id: @project, project: FactoryGirl.attributes_for(:project, :default, :unapproved)
        expect(assigns(:project)).to eq(@project)      
      end

      it "changes @project's approved field" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to eq(true)
      end

      it "redirects to the approved projects if there is no unapproved projects left" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to projects_path
      end
      
      it "redirects to the unapproved projects if there are unapproved projects left" do
        FactoryGirl.create(:project, :default, :unapproved)
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to unapproved_projects_index_path
      end
    end
    
    describe 'POST unapprove' do
      before :each do
        @project = FactoryGirl.create(:project, :default, :approved)
      end

      it "located the requested @project" do
        post :unapprove, id: @project, project: FactoryGirl.attributes_for(:project, :default, :approved)
        expect(assigns(:project)).to eq(@project)      
      end

      it "changes @project's approved field" do
        post :unapprove, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        expect(@project.approved).to eq(false)
      end

      it "redirects to the approved projects" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        expect(response).to redirect_to projects_path
      end
    end
    
    describe 'DELETE destroy' do
      before :each do
        @project = FactoryGirl.create(:project, :default)
      end
      
      it "deletes the project" do
        expect{
          delete :destroy, id: @project        
        }.to change(Project,:count).by(-1)
      end
        
      it "redirects to project#index" do
        delete :destroy, id: @project
        expect(response).to redirect_to projects_path
      end
    end
end
