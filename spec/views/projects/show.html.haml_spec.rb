require 'spec_helper'

describe 'projects/show.html.haml' do
  it 'displays project details correctly' do
    
    @current_user = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
    
    agency = FactoryGirl.build(:agency, :default, :id => 1)
    assign(:project, FactoryGirl.build(:project, :default, :id => 1, :agency => agency))

    render

    expect(rendered).to include('Test Project')
    expect(rendered).to include('This is the test project description')
    expect(rendered).to match(/open/i)
  end
  
  it 'displays a button to unapprove if project is approved' do
    @current_user = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
    
    agency = FactoryGirl.build(:agency, :default, :id => 1)
    project = FactoryGirl.build(:project, :default, :approved, :id => 1, :agency => agency)
    project.approved = true
    assign(:project, project)

    render

    expect(rendered).to include('Unapprove')
  end
  
  it 'displays a button to approve if project is unapproved' do
    @current_user = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
    
    agency = FactoryGirl.build(:agency, :default, :id => 1)
    assign(:project, FactoryGirl.build(:project, :default, :unapproved, :id => 1, :agency => agency))

    render

    expect(rendered).to include('Approve')
  end
  
end
