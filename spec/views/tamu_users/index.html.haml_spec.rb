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

    rendered.should include('John Smith')
    # rendered.should include('student')
    # rendered.should include('test@tamu.edu')
    
    rendered.should include('Name Two')
    # rendered.should include('professor')
    # rendered.should include('email2@tamu.edu')
  end
 
end
