require 'rails_helper'

RSpec.describe Agency, type: :model do
  
  it 'is invalid without name' do
      expect(Agency.new(:email => 'test@test.com', :phone_number => '817-555-5555')).to_not be_valid
  end
  
  it 'is invalid without email' do
      expect(Agency.new(:name => 'John Smith', :phone_number => '817-555-5555')).to_not be_valid
  end
  
  it 'is invalid without correctly formatted email' do
      expect(Agency.new(:name => 'John Smith', :email => 'testEmail', :phone_number => '817-555-5555')).to_not be_valid
  end
  
  it 'is invalid without correctly formatted phone number' do
      expect(Agency.new(:name => 'John Smith', :email => 'testEmail@gmail.com', :phone_number => '8175555555')).to_not be_valid
  end
  
  it "has many projects" do
    relation = Agency.reflect_on_association(:projects)
    relation.macro.should == :has_many
  end
end
