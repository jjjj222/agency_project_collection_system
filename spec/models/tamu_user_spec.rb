require 'rails_helper'

RSpec.describe TamuUser, type: :model do
  
  it 'is invalid without name' do
      expect(TamuUser.new(:email => 'test@test.com', :role => "student")).to_not be_valid
  end
  
  it 'is invalid without email' do
      expect(TamuUser.new(:name => 'John Smith', :role => "student")).to_not be_valid
  end
  
  it 'is invalid without correctly formatted email' do
      expect(TamuUser.new(:name => 'John Smith', :email => 'testEmail', :role => "student")).to_not be_valid
  end
  
  it "is invalid without a role" do
    expect(TamuUser.new(:name => 'John Smith', :email => 'test@gmail.com')).to_not be_valid
  end
  
  it "has and belongs to many projects" do
    relation = TamuUser.reflect_on_association(:projects)
    relation.macro.should == :has_and_belongs_to_many
  end

  it "should be either a student or a professor" do
    user = TamuUser.new(:name => 'John Smith', :email => "test@gmail.com", :role => "student")
    user.should satisfy { |u| u.is_student? ^ u.is_professor? }
  end
  
  it "should fail to validate a bad role" do
    expect(TamuUser.new(:name => 'John Smith', :email => "test@gmail.com", :role => "badRole")).to_not be_valid
  end
  
  it "Ensure creating as a student is a student" do
    user = TamuUser.new(:name => 'John Smith', :email => "test@gmail.com", :role => "student")
    expect(user).to be_is_student
  end
  
  it "Ensure creating as a prof is a prof" do
    user = TamuUser.new(:name => 'John Smith', :email => "test@gmail.com", :role => "professor")
    expect(user).to be_is_professor
  end
  
  it 'Test is_professor? method' do
    user = TamuUser.new(:name => 'John Smith', :email => "test@gmail.com", :role => "student")
    expect(user).to_not be_is_professor
  end
  
  it 'Test is_student? method' do
    user = TamuUser.new(:name => 'John Smith', :email => "test@gmail.com", :role => "professor")
    expect(user).to_not be_is_student
  end

end
