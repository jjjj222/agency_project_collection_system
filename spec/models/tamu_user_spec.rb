require 'rails_helper'

RSpec.describe TamuUser, type: :model do
  
  it 'is invalid without name' do
      # expect(TamuUser.new(:email => 'test@test.com', :role => "student")).to_not be_valid
      expect(FactoryGirl.build(:tamu_user, :email, :student, :admin)).to_not be_valid
  end
  
  it 'is invalid without email' do
      expect(FactoryGirl.build(:tamu_user, :name, :student, :admin)).to_not be_valid
  end

  it 'is invalid without netid' do
      expect(FactoryGirl.build(:tamu_user, :name, :student, :admin, :email)).to_not be_valid
  end
  
  it 'is invalid without correctly formatted email' do
      expect(FactoryGirl.build(:tamu_user, :default, :email => "badEmail")).to_not be_valid
  end
  
  it "is invalid without a role" do
    expect(FactoryGirl.build(:tamu_user, :name, :email, :admin)).to_not be_valid
  end
  
  #it 'is invalid without an admin specification' do
  #  expect(FactoryGirl.build(:tamu_user, :name, :email, :student)).to_not be_valid
  #end
  
  it "has and belongs to many projects" do
    relation = TamuUser.reflect_on_association(:projects)
    expect(relation.macro).to eq(:has_and_belongs_to_many)
  end

  it "should be either a student, professor, or unapproved professor" do
    user = FactoryGirl.build(:tamu_user, :default)
    expect([:student?,:professor?,:unapproved_professor?].map{|m| user.send(m)}).to contain_exactly(true, false, false)
  end
  
  it "should fail to validate a bad role" do
    expect(FactoryGirl.build(:tamu_user, :default, :role => "badRole")).to_not be_valid
  end
  
  it "Ensure creating as a student is a student" do
    user = FactoryGirl.build(:tamu_user, :default, :student)
    expect(user).to be_student
  end
  
  it "Ensure creating as a prof is a prof" do
    user = FactoryGirl.build(:tamu_user, :default, :professor)
    expect(user).to be_professor
  end

  it "Ensure creating as a unapproved prof is a unapproved prof" do
    user = FactoryGirl.build(:tamu_user, :default, :unapproved_professor)
    expect(user).to be_unapproved_professor
  end
  
  it 'Test professor? method' do
    user = FactoryGirl.build(:tamu_user, :default, :student)
    expect(user).to_not be_professor
  end
  
  it 'Test student? method' do
    user = FactoryGirl.build(:tamu_user, :default, :professor)
    expect(user).to_not be_student
  end

  it "should fail to validate nil admin" do
    user = FactoryGirl.build(:tamu_user, :default, admin: nil)
    expect(user).not_to be_valid
  end

  it "should fail to validate nil master_admin" do
    user = FactoryGirl.build(:tamu_user, :default, master_admin: nil)
    expect(user).not_to be_valid
  end

  it "should fail to validate master_admin when not admin" do
    user = FactoryGirl.build(:tamu_user, :default, master_admin: true, admin: false)
    expect(user).not_to be_valid
  end

end
