require 'rails_helper'

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

    rendered.should include('Test Agency')
    # rendered.should include('agency@nonprofit.org')
    # rendered.should include('800-700-6000')
    
    rendered.should include('Agency Two')
    # rendered.should include('another@email.com')
    # rendered.should include('817-555-5555')
  end
 
end
