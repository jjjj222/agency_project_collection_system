require 'rails_helper'

describe ApplicationHelper do
  describe "profile_for" do
    it "gives the show page for the given tamu_user" do
      tamu_user = FactoryGirl.create :tamu_user, :default
      expect(helper.profile_for(tamu_user)).to eq(tamu_user_path tamu_user)
    end
    it "gives the show page for the given agency" do
      agency = FactoryGirl.create :agency, :default
      expect(helper.profile_for(agency)).to eq(agency_path agency)
    end
    it "gives the root path for anything else" do
      expect(helper.profile_for(nil)).to eq(root_path)
    end
  end
end
