require 'rails_helper'

def login_as_user_admin
    @current_user = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
end

RSpec.describe "agencies/index.html.haml", type: :view do
    
    it 'displays all agencies correctly' do
    
    assign(:agencies,
        [
            FactoryGirl.build(:agency, :default, :id=>1),
            FactoryGirl.build(:agency, :default,
                :name => "Agency Two",
                :email=> "another@email.com",
                :phone_number=>"817-555-5555",
                :id=>2)
        ])
        
    render

    expect(rendered).to include('Test Agency')
    # rendered.should include('agency@nonprofit.org')
    # rendered.should include('800-700-6000')
    
    expect(rendered).to include('Agency Two')
    # rendered.should include('another@email.com')
    # rendered.should include('817-555-5555')
  end
  
  it 'displays unapprove button for agencies' do
    
    login_as_user_admin
     
    assign(:agencies,
        [
            FactoryGirl.build(:agency, :default, :approved, :id=>1)
        ])
        
    render

    expect(rendered).to include('Unapprove')
  end
 
end
