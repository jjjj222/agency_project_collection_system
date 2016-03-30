require 'spec_helper'

describe 'projects/show.html.haml' do
  it 'displays project details correctly' do
    assign(:project, FactoryGirl.build(:project, :default, :id => 1))

    render

    rendered.should include('Test Project')
    rendered.should include('This is the test project description')
    rendered.should include('open')
  end
end