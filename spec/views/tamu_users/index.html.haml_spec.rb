require 'rails_helper'

RSpec.describe "tamu_users/index.html.haml", type: :view do
    
    it 'displays all users correctly' do
    assign(:tamu_users,
        [
            FactoryGirl.build(:tamu_user, :default, :id=>1),
            FactoryGirl.build(:tamu_user, :default, :name => "Name Two", :email=> "email2@tamu.edu",
            :role=>"professor", :id=>2)
        ])
        
    render

    expect(rendered).to include('John Smith')
    # rendered.should include('student')
    # rendered.should include('test@tamu.edu')
    
    expect(rendered).to include('Name Two')
    # rendered.should include('professor')
    # rendered.should include('email2@tamu.edu')
  end

  context "logged in as admin" do
    before :each do
      @admin = FactoryGirl.create(:tamu_user, :default, :admin)
      @other = FactoryGirl.create(:tamu_user, :updated, :not_admin)
      # expect(view).to receive(:current_user).and_return(@admin)
      assign(:current_user, @admin)
    end

    it "should show a make admin button if there is a nonadmin" do
      assign(:tamu_users, [@admin, @other])
      render
      expect(rendered).to include("Make Admin")
    end
    it "should not show a make admin button if there is no nonadmin" do
      assign(:tamu_users, [@admin])
      render
      expect(rendered).not_to include("Make Admin")
      expect(rendered).to include("Admin")
    end

  end
 
end
