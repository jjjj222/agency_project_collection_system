require 'rails_helper'

RSpec.describe "agencies/unapproved_index.html.haml", type: :view do
    
    it 'displays all unapproved agencies correctly' do
    assign(:agencies,
        [
            FactoryGirl.build(:agency, :default, :unapproved, :id=>1),
            FactoryGirl.build(:agency, :default, :unapproved,
                :name => "Agency Two",
                :email=> "another@email.com",
                :phone_number=>"817-555-5555",
                :id=>2)
        ])
        
    render

    rendered.should include('Test Agency')
    # rendered.should include('agency@nonprofit.org')
    # rendered.should include('800-700-6000')
    
    rendered.should include('Agency Two')
    # rendered.should include('another@email.com')
    # rendered.should include('817-555-5555')
  end
  
  it 'displays approve button for agencies' do
    assign(:agencies,
        [
            FactoryGirl.build(:agency, :default, :unapproved, :id=>1)
        ])
        
    render

    rendered.should include('Approve')
  end
 
end
