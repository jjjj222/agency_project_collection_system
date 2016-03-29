require 'rails_helper'

RSpec.describe Project, type: :model do
  
  # Test data validations
  it 'is invalid without a name' do
    expect(FactoryGirl.build(:project, :description, :status, :tags)).to_not be_valid
  end
  
  it 'will be set to "open" if the status is not specified' do
    project = FactoryGirl.build(:project, :name, :description, :tags)
    project.status.should == 'open'
    #expect(FactoryGirl.build(:project, :name, :description, :tags)).to_not be_valid
  end

  it "should fail to validate a bad status" do
    expect(FactoryGirl.build(:project, :default, :status => "badStatus")).to_not be_valid
  end
  
  # Test associations
  it "project belogs to an agency" do
    relation = Project.reflect_on_association(:agency)
    relation.macro.should == :belongs_to
  end
  
  it "has and belongs to many users" do
    relation = Project.reflect_on_association(:tamu_user)
    relation.macro.should == :has_and_belongs_to_many
  end
end
