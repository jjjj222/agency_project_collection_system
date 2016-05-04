require 'rails_helper'

RSpec.describe "tamu_users/unapproved_professor_index.html.haml", type: :view do
    
    it 'displays all unapproved professors correctly' do
    assign_paginated(:tamu_users,
        [
            FactoryGirl.build(:tamu_user, :default, :unapproved_professor, :id=>1),
            FactoryGirl.build(:tamu_user, :default, :unapproved_professor,
                :name => "Billy Joel",
                :email=> "another@email.com",
                :id=>2)
        ])
        
    render

    expect(rendered).to include('John Smith')
    # rendered.should include('agency@nonprofit.org')
    # rendered.should include('800-700-6000')
    
    expect(rendered).to include('Billy Joel')
    # rendered.should include('another@email.com')
    # rendered.should include('817-555-5555')
  end
  
  it 'displays approve button for unapproved faculty' do
    assign_paginated(:tamu_users,
        [
            FactoryGirl.build(:tamu_user, :default, :unapproved_professor, :id=>1)
        ])
        
    render

    expect(rendered).to include('Approve')
  end
 
end
