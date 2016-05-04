require 'rails_helper'

RSpec.describe "projects/index.html.haml", type: :view do
    
    it 'displays all users correctly' do
    @agency = FactoryGirl.build(:agency, :default, :id=>1)
    assign_paginated(:projects,
        [
            FactoryGirl.build(:project, :default, :agency=>@agency, :id=>1),
            FactoryGirl.build(:project, :default,
                :name => "Project Two",
                :description=> "Yet another description",
                :status=>"completed",
                :agency=>@agency,
                :id=>2)
        ])
        
    render

    expect(rendered).to include('Test Project')
    expect(rendered).to include('This is the test project description')
    expect(rendered).to match(/open/i)
    
    expect(rendered).to include('Project Two')
    expect(rendered).to include('Yet another description')
    expect(rendered).to match(/completed/i)
  end
  
    it 'displays unapprove button for projects' do
      @current_user = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
      @agency = FactoryGirl.build(:agency, :default, :id=>1)
      assign_paginated(:projects,
          [
              FactoryGirl.build(:project, :default, :agency=>@agency, :id=>1)
          ])

      render

      expect(rendered).to include('Unapprove')

    end
    context "asked to sort" do
      before :each do
        @current_user = FactoryGirl.build(:tamu_user, :default, :admin, :id=>1)
        @agency = FactoryGirl.build(:agency, :default, :id=>1)
        assign_paginated(:projects,
            [
                FactoryGirl.build(:project, :default, :agency=>@agency, :id=>1)
            ])
      end

      it "should have a link to sort by agency, name, date" do
        render
        expect(rendered).to include("sort=name")
        expect(rendered).to include("sort=agency")
        expect(rendered).to include("sort=date")
      end


      it "should have appropriate links if already sorting by name" do
        allow(view).to receive(:params).and_return({"sort" => "name"})
        render
        expect(rendered).to include("reverse=true&amp;sort=name")
        expect(rendered).to include("sort=agency")
        expect(rendered).to include("sort=date")
      end
      it "should have appropriate links if already sorting by agency" do
        allow(view).to receive(:params).and_return({"sort" => "agency"})
        render
        expect(rendered).to include("sort=name")
        expect(rendered).to include("reverse=true&amp;sort=agency")
        expect(rendered).to include("sort=date")
      end
      it "should have appropriate links if already sorting by date" do
        allow(view).to receive(:params).and_return({"sort" => "date"})
        render
        expect(rendered).to include("sort=name")
        expect(rendered).to include("sort=agency")
        expect(rendered).to include("reverse=true&amp;sort=date")
      end
    end
 
end
