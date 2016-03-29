require 'rails_helper'

RSpec.describe "projects/index.html.haml", type: :view do
    
    it 'displays all users correctly' do
    assign(:projects,
        [
            FactoryGirl.build(:project, :default, :id=>1),
            FactoryGirl.build(:project, :default,
                :name => "Project Two",
                :description=> "Yet another description",
                :status=>"completed",
                :id=>2)
        ])
        
    render

    rendered.should include('Test Project')
    rendered.should include('This is the test project description')
    rendered.should include('open')
    
    rendered.should include('Project Two')
    rendered.should include('Yet another description')
    rendered.should include('completed')
  end
 
end
