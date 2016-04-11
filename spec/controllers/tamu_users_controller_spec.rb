require 'rails_helper'

RSpec.describe TamuUsersController, type: :controller do

    describe "GET #index" do
        it "populates an array of tamu users" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :index
            expect(assigns(:tamu_users)).to eq([tamu_user])
        end
        
        it "renders the :index view" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            session[:user_id] = tamu_user.id
            session[:user_type] = "TamuUser"

            get :index
            expect(response).to render_template :index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested tamu user to @tamu_user" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :show, id: tamu_user
            expect(assigns(:tamu_user)).to eq(tamu_user)
        end
        
        
        it "it renders the :show view" do
            get :show, id: FactoryGirl.create(:tamu_user, :default)
            expect(response).to render_template :show
        end
    end
    describe 'PUT update' do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
      end
  
      context "valid attributes" do
        it "located the requested @tamu_user" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
          expect(assigns(:tamu_user)).to eq(@tamu_user)      
        end
  
        it "changes @tamu_user's attributes, but not role" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :updated)
          @tamu_user.reload
          expect(@tamu_user.name).to eq("Updated Smith")
          expect(@tamu_user.role).to eq("student")
          expect(@tamu_user.email).to eq("new_prof@tamu.edu")
        end
  
        it "redirects to the updated tamu_user" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :default)
          expect(response).to redirect_to @tamu_user
        end
        
      end
  
      context "invalid attributes" do
        it "locates the requested @tamu_user" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          expect(assigns(:tamu_user)).to eq(@tamu_user)      
        end
    
        it "does not change @tamu_user's attributes" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          @tamu_user.reload
          expect(@tamu_user.name).to eq("John Smith")
          expect(@tamu_user.role).to eq("student")
          expect(@tamu_user.email).to eq("test@tamu.edu")
        end
    
        it "re-renders the edit method" do
          put :update, id: @tamu_user, tamu_user: FactoryGirl.attributes_for(:tamu_user, :invalid)
          expect(response).to render_template :edit
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
        expect(response).to redirect_to tamu_users_path
      end
    end

end
