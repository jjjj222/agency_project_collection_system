require 'rails_helper'

describe 'tamu_users/edit.html.haml' do
    
    context 'given a user with correct data' do
        before do
            @tamu_user = FactoryGirl.build(:tamu_user, :default, :id=>1)
            assign :tamu_user, @tamu_user
            render
        end

        it 'has a form for editing the user' do
            expect(rendered).to have_selector('form#edit_user_form')
        end

        it 'displays a text field for name' do
            expect(rendered).to have_field("Name", with: @tamu_user.name)
        end

        it 'displays a text field for email' do
            expect(rendered).to have_field("Email", with: @tamu_user.email)
        end

        it 'displays a drop down for user role' do
            expect(rendered).to have_selector("select#tamu_user_role")
        end
    end
end
