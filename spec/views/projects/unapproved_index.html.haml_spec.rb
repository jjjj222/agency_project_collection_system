require 'rails_helper'


def login_as_user_admin
    @admin = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
    @current_user = @admin
end

def login_as_user_non_admin
    @tamu_user = FactoryGirl.build(:tamu_user, :default, :not_admin, :id=>1)
    @current_user = @tamu_user
end

def login_as_agency
    @agency = FactoryGirl.build(:agency, :default, :approved, :id=>1)
    @current_user = @agency
end

RSpec.describe "projects/unapproved_index.html.haml", type: :view do
    
    it 'displays all unapproved projects correctly' do
    
    login_as_user_admin
    
    @agency = FactoryGirl.build(:agency, :default, :approved, :id=>1)
    
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
  
  it 'displays approve button for projects' do
    
    login_as_user_admin
    
    
    @agency = FactoryGirl.build(:agency, :default, :approved, :id=>1)
    assign(:projects,
        [
            FactoryGirl.build(:project, :default, :unapproved, :agency => @agency, :id=>1)
        ])
        
    render

    expect(rendered).to include('Approve')
  end
 
end
