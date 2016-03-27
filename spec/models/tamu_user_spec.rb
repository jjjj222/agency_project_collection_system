require 'rails_helper'

RSpec.describe TamuUser, type: :model do
  
  it 'is invalid without name' do
      # expect(TamuUser.new(:email => 'test@test.com', :role => "student")).to_not be_valid
      expect(FactoryGirl.build(:tamu_user, :email, :student)).to_not be_valid
  end
  
  it 'is invalid without email' do
      expect(FactoryGirl.build(:tamu_user, :name, :student)).to_not be_valid
  end
  
  it 'is invalid without correctly formatted email' do
      expect(FactoryGirl.build(:tamu_user, :default, :email => "badEmail")).to_not be_valid
  end
  
  it "is invalid without a role" do
    expect(FactoryGirl.build(:tamu_user, :name, :email)).to_not be_valid
  end
  
  it "has and belongs to many projects" do
    relation = TamuUser.reflect_on_association(:projects)
    relation.macro.should == :has_and_belongs_to_many
  end

  it "should be either a student or a professor" do
    user = FactoryGirl.build(:tamu_user, :default)
    user.should satisfy { |u| u.is_student? ^ u.is_professor? }
  end
  
  it "should fail to validate a bad role" do
    expect(FactoryGirl.build(:tamu_user, :default, :role => "badRole")).to_not be_valid
  end
  
  it "Ensure creating as a student is a student" do
    user = FactoryGirl.build(:tamu_user, :default, :student)
    expect(user).to be_is_student
  end
  
  it "Ensure creating as a prof is a prof" do
    user = FactoryGirl.build(:tamu_user, :default, :professor)
    expect(user).to be_is_professor
  end
  
  it 'Test is_professor? method' do
    user = FactoryGirl.build(:tamu_user, :default, :student)
    expect(user).to_not be_is_professor
  end
  
  it 'Test is_student? method' do
    user = FactoryGirl.build(:tamu_user, :default, :professor)
    expect(user).to_not be_is_student
  end

end
