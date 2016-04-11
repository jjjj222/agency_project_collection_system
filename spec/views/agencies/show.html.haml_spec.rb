require 'spec_helper'

describe 'agencies/show.html.haml' do
  it 'displays agency details correctly' do
    assign(:agency, FactoryGirl.build(:agency, :default, :id => 1))

    render

    expect(rendered).to include('Test Agency')
    expect(rendered).to include('agency@nonprofit.org')
    expect(rendered).to include('800-700-6000')
  end
  
  it 'displays an agencies projects correctly' do
    assign(:agency, FactoryGirl.build(:agency, :default, :id => 1,
        :projects => [FactoryGirl.build(:project, :default, :id=>1)]
        ))

    render

    expect(rendered).to include('Test Project')
    expect(rendered).to include('This is the test project description')
    expect(rendered).to include('open')
  end
  
  it 'displays a button to unapprove if agency is approved' do
    assign(:agency, FactoryGirl.build(:agency, :default, :id => 1))

    render

    expect(rendered).to include('Unapprove')
  end
  
  it 'displays a button to approve if agency is unapproved' do
    assign(:agency, FactoryGirl.build(:agency, :default, :unapproved, :id => 1))

    render

    expect(rendered).to include('Approve')
  end
end
