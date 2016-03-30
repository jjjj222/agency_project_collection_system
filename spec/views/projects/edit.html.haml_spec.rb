require 'spec_helper'

describe 'projects/edit.html.haml' do
    
    context 'given a project with correct data' do
        before do
            @project = FactoryGirl.build(:project, :default, :id=>1)
            assign :project, @project
            render
        end
        
        it 'displays a text field for name' do
            rendered.should have_selector('form#edit_project_form') do |form|
              form.should have_selector('textarea',
                                        :name => 'project[name]')
            end
        end
        
        it 'displays a text field for description' do
            rendered.should have_selector('form#edit_project_form') do |form|
              form.should have_selector('textarea',
                                        :name => 'project[description]')
            end
        end
        
        it 'displays a text field for tags' do
            rendered.should have_selector('form#edit_project_form') do |form|
              form.should have_selector('textarea',
                                        :name => 'project[tags]')
            end
        end
        
        it 'displays a text field for status' do
            rendered.should have_selector('form#edit_project_form') do |form|
              form.should have_selector('textarea',
                                        :name => 'project[status]')
            end
        end
    end
end