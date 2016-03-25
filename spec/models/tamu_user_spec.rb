require 'spec_helper'

RSpec.describe TamuUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should be either a student or a professor" do
    user = TamuUser.new
    user.should satisfy { |u| u.is_student? ^ u.is_professor? }
  end
end
