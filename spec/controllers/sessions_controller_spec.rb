require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #tamu_create" do

    context "valid login" do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        @attrs = { email: @tamu_user.email }
      end

      it "should should log the user in" do
        post :tamu_create, session: @attrs
        expect(controller).to be_logged_in
        expect(controller.current_user).to eq(@tamu_user)
        # todo: what should happen next?
      end
    end
    context "invalid login" do
      it "should not be logged in" do
        #todo: test bad params case?
        post :tamu_create, session: {email: ""}
        expect(controller).to_not be_logged_in
      end
      #todo: what else should happen?
    end
  end

  describe "DELETE #destroy" do
    context "logged in" do
      before :each do
        @tamu_user = FactoryGirl.create(:tamu_user, :default)
        controller.log_in(@tamu_user, "TamuUser")
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


end
