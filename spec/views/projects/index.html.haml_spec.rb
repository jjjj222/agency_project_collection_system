require 'rails_helper'


def login_as_user_admin
    @current_user = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
end

RSpec.describe "projects/index.html.haml", type: :view do
    
    it 'displays all users correctly' do
    @agency = FactoryGirl.build(:agency, :default, :id=>1)
    assign(:projects,
        [
            FactoryGirl.build(:project, :default, :agency=>@agency, :id=>1),
            FactoryGirl.build(:project, :default,
                :name => "Project Two",
                :description=> "Yet another description",
                :status=>"completed",
                :agency=>@agency,
                :id=>2)
        ])
        
    render

    expect(rendered).to include('Test Project')
    expect(rendered).to include('This is the test project description')
    expect(rendered).to include('open')
    
    expect(rendered).to include('Project Two')
    expect(rendered).to include('Yet another description')
    expect(rendered).to include('completed')
  end
  
    it 'displays unapprove button for projects' do
    login_as_user_admin
    @agency = FactoryGirl.build(:agency, :default, :id=>1)
    assign(:projects,
        [
            FactoryGirl.build(:project, :default, :agency=>@agency, :id=>1)
        ])
        
    render

    expect(rendered).to include('Unapprove')
  end
 
end
