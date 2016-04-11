require 'spec_helper'

describe 'tamu_users/edit.html.haml' do
    
    context 'given a user with correct data' do
        before do
            @tamu_user = FactoryGirl.build(:tamu_user, :default, :id=>1)
            assign :tamu_user, @tamu_user
            render
        end
        
        it 'displays a text field for name' do
            expect(rendered).to have_selector('form#edit_user_form') do |form|
              expect(form).to have_selector('textarea',
                                        :name => 'tamu_user[name]')
            end
        end
        
        it 'displays a text field for email' do
            expect(rendered).to have_selector('form#edit_user_form') do |form|
              expect(form).to have_selector('textarea',
                                        :name => 'tamu_user[email]')
            end
        end
    end
end
