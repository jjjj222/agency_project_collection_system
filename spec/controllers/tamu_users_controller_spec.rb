require 'rails_helper'

RSpec.describe TamuUsersController, type: :controller do

    describe "GET #index" do
        it "populates an array of tamu users" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :index
            assigns(:tamu_users).should eq([tamu_user])
        end
        
        it "renders the :index view" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            session[:user_id] = tamu_user.id
            session[:user_type] = "TamuUser"

            get :index
            response.should render_template :index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested tamu user to @tamu_user" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :show, id: tamu_user
            assigns(:tamu_user).should eq(tamu_user)
        end
        
        
        it "it renders the :show view" do
            get :show, id: FactoryGirl.create(:tamu_user, :default)
            response.should render_template :show
        end
    end
    describe 'PUT update' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
      end
  
      context "valid attributes" do
        it "located the requested @tamu_user" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
          assigns(:tamu_user).should eq(@tamu_user)      
        end
  
        it "changes @tamu_user's attributes, but not role" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :updated)
          @tamu_user.reload
          @tamu_user.name.should eq("Updated Smith")
          @tamu_user.role.should eq("student")
          @tamu_user.email.should eq("new_prof@tamu.edu")
        end
  
        it "redirects to the updated tamu_user" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
          response.should redirect_to @tamu_user
        end
        
      end
  
      context "invalid attributes" do
        it "locates the requested @tamu_user" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          assigns(:tamu_user).should eq(@tamu_user)      
        end
    
        it "does not change @tamu_user's attributes" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          @tamu_user.reload
          @tamu_user.name.should eq("John Smith")
          @tamu_user.role.should eq("student")
          @tamu_user.email.should eq("test@tamu.edu")
        end
    
        it "re-renders the edit method" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          response.should render_template :edit
        end
      end
    end
    
    describe 'DELETE destroy' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
      end
      
      it "deletes the tamu_user" do
        expect{
          delete :destroy, id: @tamu_user        
        }.to change(TamuUser,:count).by(-1)
      end
        
      it "redirects to tamu_user#index" do
        delete :destroy, id: @tamu_user
        response.should redirect_to tamu_users_path
      end
    end

end
