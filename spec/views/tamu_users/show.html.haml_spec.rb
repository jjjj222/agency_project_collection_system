require 'spec_helper'

describe 'tamu_users/show.html.haml' do
  it 'displays user details correctly' do
    assign(:tamu_user, FactoryGirl.build(:tamu_user, :default, :id=>1))

    render

    rendered.should include('John Smith')
    rendered.should include('test@tamu.edu')
    rendered.should include('Student')
    rendered.should include("<p id='admin'>true</p>")
  end
  
  it 'displays a users projects correctly' do
    assign(:tamu_user, FactoryGirl.build(:tamu_user, :default, :id=>1,
        :projects => [FactoryGirl.build(:project, :default, :id=>1)]
        ))

    render

    rendered.should include('Test Project')
    rendered.should include('This is the test project description')
    rendered.should include('open')
  end
end