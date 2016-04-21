require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
describe SessionsHelper do
  # describe "log in" do
  #   it "should not be logged in at first" do
  #     expect(helper).not_to be_logged_in
  #   end

  #   context "agency logged in" do
  #     before :each do
  #       agency = FactoryGirl.create(:agency, :default)
  #       helper.log_in(agency)
  #     end
  #     it "should be logged in after calling log in" do
  #       expect(helper).to be_logged_in
  #     end
  #     it "should be logged out after logging out" do
  #       helper.log_out
  #       expect(helper.logged_in?).to be false
  #     end
  #   end

  #   context "tamu_user logged in" do
  #     before :each do
  #       tamu_user = FactoryGirl.create(:tamu_user, :default)
  #       helper.log_in(tamu_user)
  #     end
  #     it "should be logged in after calling log in" do
  #       expect(helper).to be_logged_in
  #     end
  #     it "should be logged out after logging out" do
  #       helper.log_out
  #       expect(helper).not_to be_logged_in
  #     end
  #   end

  describe "fix_cas_session" do
    it "makes symbolized versions of keys avaiable in session[:cas]" do
      session[:cas] = { "user" => "bob" }
      helper.fix_cas_session
      expect(session[:cas]).to have_key(:user)
    end
  end

  describe "cas_logged_in?" do
    it "should return false if no cas in session" do
      expect(helper).not_to be_cas_logged_in
    end

    context "there is a :cas in session" do
      before :each do
        session[:cas] = Hash.new
      end

      it "should return false if there is nothing in :cas" do
        expect(helper).not_to be_cas_logged_in
      end
      it "should return true if there is :user in :cas" do
        session[:cas][:user] = "bob"
        expect(helper).to be_cas_logged_in
      end
      it "should return true if there is string user in :cas" do
        session[:cas]["user"] = "bob"
        expect(helper).to be_cas_logged_in
      end
    end

  end


end
#RSpec.describe SessionsHelper, type: :helper do
#  pending "add some examples to (or delete) #{__FILE__}"
#end
