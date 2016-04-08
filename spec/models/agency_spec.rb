require 'rails_helper'

RSpec.describe Agency, type: :model do
  
  it 'is invalid without name' do
      expect(FactoryGirl.build(:agency, :email, :phone_number)).to_not be_valid
  end
  
  it 'is invalid without email' do
      expect(FactoryGirl.build(:agency, :name, :phone_number)).to_not be_valid
  end
  
  it 'is invalid without correctly formatted email' do
      expect(FactoryGirl.build(:agency, :default, email: "testEmail")).to_not be_valid
  end
  
  it 'is invalid without correctly formatted phone number' do
      expect(FactoryGirl.build(:agency, :default, phone_number: "0090950909090909")).to_not be_valid
  end
  
  it 'is invalid without an approved classification' do
    expect(FactoryGirl.build(:agency, :name, :email, :phone_number, :nil_approved)).to_not be_valid
  end
  
  it "has many projects" do
    relation = Agency.reflect_on_association(:projects)
    relation.macro.should == :has_many
  end
end
