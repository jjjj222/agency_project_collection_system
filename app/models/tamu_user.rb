class TamuUser < ActiveRecord::Base
  def is_student?
    false
  end
  
  def is_professor?
    false
  end
end
