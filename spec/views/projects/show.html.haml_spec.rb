require 'spec_helper'

describe 'projects/show.html.haml' do
  it 'displays project details correctly' do
    admin = FactoryGirl.build(:tamu_user, :default, :admin)
    view.log_in(admin)
    agency = FactoryGirl.build(:agency, :default, :id => 1)
    assign(:project, FactoryGirl.build(:project, :default, :id => 1, :agency => agency))

    render

    expect(rendered).to include('Test Project')
    expect(rendered).to include('This is the test project description')
    expect(rendered).to include('open')
  end
  
  it 'displays a button to unapprove if project is approved' do
    admin = FactoryGirl.build(:tamu_user, :default, :admin)
    view.log_in(admin)
    agency = FactoryGirl.build(:agency, :default, :id => 1)
    project = FactoryGirl.build(:project, :default, :approved, :id => 1, :agency => agency)
    project.approved = true
    assign(:project, project)

    render

    expect(rendered).to include('Unapprove')
  end
  
  it 'displays a button to approve if project is unapproved' do
    admin = FactoryGirl.build(:tamu_user, :default, :admin)
    view.log_in(admin)
    agency = FactoryGirl.build(:agency, :default, :id => 1)
    assign(:project, FactoryGirl.build(:project, :default, :unapproved, :id => 1, :agency => agency))

    render

    expect(rendered).to include('Approve')
  end
  
end
