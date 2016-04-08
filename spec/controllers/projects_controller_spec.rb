require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    
    describe "GET #index" do
        it "populates an array of projects" do
            project = FactoryGirl.create(:project, :default, :approved)
            get :index
            assigns(:projects).should eq([project])
        end
        
        it "renders the :index view" do
            get :index
            response.should render_template :index
        end
    end
    
    describe "GET #unapproved index" do
        it "populates an array of projects" do
            project = FactoryGirl.create(:project, :default, :unapproved)
            get :unapproved_index
            assigns(:projects).should eq([project])
        end
        
        it "renders the :index view" do
            get :unapproved_index
            response.should render_template :unapproved_index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested tamu user to @tamu_user" do
            project = FactoryGirl.create(:project, :default)
            get :show, id: project
            assigns(:project).should eq(project)
        end
        
        
        it "it renders the :show view" do
            get :show, id: FactoryGirl.create(:project, :default)
            response.should render_template :show
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
          response.should redirect_to Project.last
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
          assigns(:project).should eq(@project)      
        end
  
        it "changes @project's attributes" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :updated)
          @project.reload
          @project.name.should eq("Test Project updated")
          @project.description.should eq("This is the test project description updated")
          @project.status.should eq("completed")
          @project.tags.should eq(["updated"])
        end
  
        it "redirects to the updated project" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :default)
          response.should redirect_to @project
        end
        
      end
  
      context "invalid attributes" do
        it "locates the requested @project" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          assigns(:project).should eq(@project)      
        end
    
        it "does not change @project's attributes" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          @project.reload
          @project.name.should eq("Test Project")
          @project.description.should eq("This is the test project description")
          @project.status.should eq("open")
          @project.tags.should eq([""])
        end
    
        it "re-renders the edit method" do
          put :update, id: @project, project: FactoryGirl.attributes_for(:project, :invalid)
          response.should render_template :edit
        end
      end
    end
    
    describe 'POST approve' do
      before :each do
        @project = FactoryGirl.create(:project, :default, :unapproved)
      end

      it "located the requested @project" do
        post :approve, id: @project, project: FactoryGirl.attributes_for(:project, :default, :unapproved)
        assigns(:project).should eq(@project)      
      end

      it "changes @project's approved field" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        @project.approved.should eq(true)
      end

      it "redirects to the approved projects if there is no unapproved projects left" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        response.should redirect_to projects_path
      end
      
      it "redirects to the unapproved projects if there are unapproved projects left" do
        FactoryGirl.create(:project, :default, :unapproved)
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        response.should redirect_to unapproved_projects_index_path
      end
    end
    
    describe 'POST unapprove' do
      before :each do
        @project = FactoryGirl.create(:project, :default, :approved)
      end

      it "located the requested @project" do
        post :unapprove, id: @project, project: FactoryGirl.attributes_for(:project, :default, :approved)
        assigns(:project).should eq(@project)      
      end

      it "changes @project's approved field" do
        post :unapprove, id: @project#, project: FactoryGirl.attributes_for(:project, :default, :approved)
        @project.reload
        @project.approved.should eq(false)
      end

      it "redirects to the approved projects" do
        post :approve, id: @project#, project: FactoryGirl.attributes_for(:project, :default)
        response.should redirect_to projects_path
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
        response.should redirect_to projects_path
      end
    end
end
