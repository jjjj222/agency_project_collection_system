class TamuUser < ActiveRecord::Base
  def is_student?
    false
  end
  
  def is_professor?
    not is_student?
  end
end
