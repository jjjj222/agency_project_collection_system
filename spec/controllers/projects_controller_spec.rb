require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    
    describe "GET #index" do
        it "populates an array of projects" do
            project = FactoryGirl.create(:project, :default)
            get :index
            assigns(:projects).should eq([project])
        end
        
        it "renders the :index view" do
            get :index
            response.should render_template :index
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
            post :create, project: FactoryGirl.build(:project, :default)
          }.to change(Project,:count).by(1)
        end
        
        it "redirects to the new contact" do
          post :create, project: FactoryGirl.attributes_for(:project, :default)
          response.should redirect_to Project.last
        end
      end
      
    #   context "with invalid attributes" do
    #     it "does not save the new contact" do
    #       expect{
    #         post :create, project: Factory.attributes_for(:invalid_project)
    #       }.to_not change(Project,:count)
    #     end
        
    #     it "re-renders the new method" do
    #       post :create, project: Factory.attributes_for(:invalid_project)
    #       response.should render_template :new
    #     end
    #   end 
    end
end
