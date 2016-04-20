require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #tamu_create" do
    # needs to be rewritten for CAS now
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
end
