require 'spec_helper'

describe 'projects/new.html.haml' do
    
    context 'given a new project data' do
        before do
            @project = FactoryGirl.build(:project, :default, :id=>1)
            assign :project, @project
            render
        end

        it 'has a form for a new project' do
            expect(rendered).to have_selector('form#new_project_form')
        end
        
        it 'displays a text field for name' do
            expect(rendered).to have_field("Name", with: @project.name)
        end

        it 'has a field for description' do
            expect(rendered).to have_field("Description", with: @project.description)
        end
        
        it 'has a field for tags' do
            expect(rendered).to have_field("Tags", with: @project.tags.join(", "))
        end
        
        it 'displays a hidden field for status with value of open' do
            expect(rendered).to have_selector('#project_status', visible: false)
            expect(rendered).to have_selector("input#project_status[value=\"open\"]", visible: false)
        end
    end
end
