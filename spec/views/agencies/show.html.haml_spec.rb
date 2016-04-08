require 'spec_helper'

describe 'agencies/show.html.haml' do
  it 'displays agency details correctly' do
    assign(:agency, FactoryGirl.build(:agency, :default, :id => 1))

    render

    rendered.should include('Test Agency')
    rendered.should include('agency@nonprofit.org')
    rendered.should include('800-700-6000')
  end
  
  it 'displays an agencies projects correctly' do
    assign(:agency, FactoryGirl.build(:agency, :default, :id => 1,
        :projects => [FactoryGirl.build(:project, :default, :id=>1)]
        ))

    render

    rendered.should include('Test Project')
    rendered.should include('This is the test project description')
    rendered.should include('open')
  end
  
  it 'displays a button to unapprove if agency is approved' do
    assign(:agency, FactoryGirl.build(:agency, :default, :id => 1))

    render

    rendered.should include('Unapprove')
  end
  
  it 'displays a button to approve if agency is unapproved' do
    assign(:agency, FactoryGirl.build(:agency, :default, :unapproved, :id => 1))

    render

    rendered.should include('Approve')
  end
end