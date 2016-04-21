require 'spec_helper'

def login_as_agency
    @agency = FactoryGirl.build(:agency, :default, :approved, :id=>1)
    @current_user = @agency
end

describe 'projects/edit.html.haml' do
    
    context 'given a project with correct data' do
        before do
            login_as_agency
            @project = FactoryGirl.build(:project, :default, :agency=>@agency, :id=>1)
            assign :project, @project
            render
        end

        it 'has a form for editing the project' do
            expect(rendered).to have_selector('form#edit_project_form')
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
        
        it 'has a drop-down for status' do
            expect(rendered).to have_select("Status",
                                            #selected: @project.status.capitalize,
                                            options: Project.all_statuses.map(&:capitalize))
        end
    end
end
