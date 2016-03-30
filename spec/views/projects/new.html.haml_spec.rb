require 'spec_helper'

describe 'projects/new.html.haml' do
    
    context 'given a new project data' do
        before do
            @project = FactoryGirl.build(:project, :default, :id=>1)
            assign :project, @project
            render
        end
        
        it 'displays a text field for name' do
            rendered.should have_selector('form#new_project_form') do |form|
              form.should have_selector('textarea',
                                        :name => 'project[name]')
            end
        end
        
        it 'displays a text field for description' do
            rendered.should have_selector('form#new_project_form') do |form|
              form.should have_selector('textarea',
                                        :name => 'project[description]')
            end
        end
        
        it 'displays a text field for tags' do
            rendered.should have_selector('form#new_project_form') do |form|
              form.should have_selector('textarea',
                                        :name => 'project[tags]')
            end
        end
        
        it 'displays a hidden field for status' do
            rendered.should have_selector('form#new_project_form') do |form|
              form.should have_selector('hidden_field',
                                        :name => 'project[status]',
                                        :value => 'open')
            end
        end
    end
end