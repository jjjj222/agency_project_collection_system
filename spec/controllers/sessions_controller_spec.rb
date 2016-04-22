require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  #TODO: find a place to put this, also in tamu users atm
  def cas_log_in(user)
    cas_hash = { user: user.netid, extra_attributes: { 'tamuEduPersonNetID' => user.netid } }
    session[:cas] = cas_hash
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #tamu_new" do
    context "not yet authenticated" do
      it "should render a 401" do
        post :tamu_new
        expect(response).to have_http_status(401)
      end
    end
    context "logging in as admin" do
      before :each do
        @admin = FactoryGirl.create(:tamu_user, :default, :admin)
      end
      it "should redirect to user profile" do
        cas_log_in @admin
        post :tamu_new
        expect(response).to redirect_to tamu_user_path(@admin)
      end
      it "should find the correct user" do
        cas_log_in @admin
        post :tamu_new
        expect(controller.current_user).to eq(@admin)
      end
    end

    context "logging in as new user" do
      before :each do
        @user = FactoryGirl.build(:tamu_user, :default)
      end

      it "should redirect to the new user page" do
        cas_log_in @user
        post :tamu_new
        expect(response).to redirect_to new_tamu_user_path
      end
    end



    #TODO: more

  end

  describe "DELETE #destroy" do
    context "logged in" do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        controller.log_in(@tamu_user)
      end

      it "should log them out" do
        delete :destroy
        expect(controller).to_not be_logged_in
      end
      it "should take them to the root page" do
        delete :destroy
        expect(response).to redirect_to root_path
      end
    end
    #todo: context for not logged in?
  end

  describe "GET #auth" do
    context "we have an agency" do
      before :each do
        @agency = FactoryGirl.create(:agency, :default, uid: "12345")
      end
      context "auth succeeeds" do
        before :each do
         expect(controller).to receive(:get_auth_hash).and_return({ 'uid' => @agency.uid, 'provider' => @agency.provider })
          get :create, provider: 'google_oauth2'
        end
        it "should set the session user id" do
          expect(session[:user_id]).to eq(@agency.id)
        end
        it "should set the session user type" do
          expect(session[:user_type]).to eq(@agency.class.name)
        end
        it "should find the correct agency" do
          expect(controller.current_user).to eq @agency
        end
        it { expect(controller).to be_logged_in }

      end

      context "auth fails" do
        before :each do
          expect(controller).to receive(:get_auth_hash).and_raise("Some error")
          get :create, provider: 'google_oauth2'
        end

        it "should mention the failure" do
          expect(flash[:warning]).to include("error")
        end
        it { expect(controller).not_to be_logged_in }
      end

    end
  end

end
