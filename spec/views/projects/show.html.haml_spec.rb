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

  it 'displays the project name and users working on it if user logged in' do
    @current_user = FactoryGirl.create(:tamu_user, :default)
    @agency = FactoryGirl.create(:agency, :default, :approved)
    @project = FactoryGirl.create(:project, :default, :approved, agency: @agency)
    @current_user.projects << @project

    assign(:project, @project)

    render

    expect(rendered).to include(@current_user.name)
    expect(rendered).to include(@project.name)
  end

  it 'displays an edit and delete if logged in as the owning ageny' do
    @current_user = FactoryGirl.create(:agency, :default, :approved)
    @project = FactoryGirl.create(:project, :default, :approved, agency: @current_user)

    assign(:project, @project)

    render

    expect(rendered).to include('Edit')
    expect(rendered).to include('Delete')
  end

  
end
