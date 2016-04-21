require 'spec_helper'

describe 'tamu_users/show.html.haml' do
  it 'displays user details correctly' do
    
    @current_user = FactoryGirl.build(:tamu_user, :default, :not_admin, :id=>1)
    
    assign(:tamu_user, FactoryGirl.build(:tamu_user, :default, :id=>1))

    render

    expect(rendered).to include('John Smith')
    expect(rendered).to include('test@tamu.edu')
    expect(rendered).to include('Student')
  end
  
  it 'displays a users projects correctly' do
    assign(:tamu_user, FactoryGirl.build(:tamu_user, :default, :id=>1,
        :projects => [FactoryGirl.build(:project, :default, :id=>1)]
        ))

    render

    expect(rendered).to include('Test Project')
    expect(rendered).to include('This is the test project description')
    expect(rendered).to include('open')
  end
end
