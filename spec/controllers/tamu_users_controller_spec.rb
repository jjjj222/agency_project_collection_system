require 'rails_helper'

RSpec.describe TamuUsersController, type: :controller do

    describe "GET #index" do
        it "populates an array of tamu users" do
            tamu_user = FactoryGirl.create(:tamu_user, :default)
            get :index
            assigns(:tamu_users).should eq([tamu_user])
        end
        
        it "renders the :index view" do
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

end
