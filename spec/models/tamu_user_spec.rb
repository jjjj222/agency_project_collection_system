require 'spec_helper'

RSpec.describe TamuUser, type: :model do
  
  it 'is invalid without name' do
      expect(TamuUser.new(:email => 'test@test.com')).to_not be_valid
  end
  
  it 'is invalid without email' do
      expect(TamuUser.new(:name => 'John Smith')).to_not be_valid
  end
  
  it 'is invalid without correctly formatted email' do
      expect(TamuUser.new(:name => 'John Smith', :email => 'testEmail')).to_not be_valid
  end
  
  it "has and belongs to many projects" do
    relation = TamuUser.reflect_on_association(:projects)
    relation.macro.should == :has_and_belongs_to_many
  end

  it "should be either a student or a professor" do
    user = TamuUser.new
    user.should satisfy { |u| u.is_student? ^ u.is_professor? }
  end
  
  # Pendings
  pending "Ensure creating as a student is a student"
  pending "Ensure creating as a prof is a prof"
end
