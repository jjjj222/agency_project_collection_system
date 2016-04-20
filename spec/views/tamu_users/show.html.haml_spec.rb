require 'spec_helper'

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

describe 'tamu_users/show.html.haml' do
  it 'displays user details correctly' do
    
    login_as_user_non_admin
    
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
