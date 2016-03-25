require 'spec_helper'

RSpec.describe Project, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should fail to validate a bad status" do
    Project.new(name:"bad", description:"bad",status:"bad").should_not be_valid
  end
end
