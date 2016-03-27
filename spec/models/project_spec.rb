require 'rails_helper'

RSpec.describe Project, type: :model do
  
  # Test data validations
  it 'is invalid without a name' do
    expect(Project.new(:description => "This test project's description", :status => "open")).to_not be_valid
  end
  
  it 'is invalid without a status' do
    expect(Project.new(:name => "Test Project", :description => "This test project's description")).to_not be_valid
  end

  it "should fail to validate a bad status" do
    expect(Project.new(:name => "Test Project", :description => "This test project's description", :status => "badStatus")).to_not be_valid
  end
  
  # Test associations
  it "project belogs to an agency" do
    relation = Project.reflect_on_association(:agency)
    relation.macro.should == :belongs_to
  end
  
  it "has and belongs to many users" do
    relation = Project.reflect_on_association(:user)
    relation.macro.should == :has_and_belongs_to_many
  end
end
