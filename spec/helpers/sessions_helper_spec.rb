require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
describe SessionsHelper do
  describe "log in" do
    it "should not be logged in at first" do
      expect(helper).not_to be_logged_in
    end

    context "agency logged in" do
      before :each do
        agency = FactoryGirl.create(:agency, :default)
        helper.log_in(agency)
      end
      it "should be logged in after calling log in" do
        expect(helper).to be_logged_in
      end
      it "should be logged out after logging out" do
        helper.log_out
        expect(helper.logged_in?).to be false
      end
    end

    context "tamu_user logged in" do
      before :each do
        tamu_user = FactoryGirl.create(:tamu_user, :default)
        helper.log_in(tamu_user)
      end
      it "should be logged in after calling log in" do
        expect(helper).to be_logged_in
      end
      it "should be logged out after logging out" do
        helper.log_out
        expect(helper).not_to be_logged_in
      end
    end

  end
end
#RSpec.describe SessionsHelper, type: :helper do
#  pending "add some examples to (or delete) #{__FILE__}"
#end
