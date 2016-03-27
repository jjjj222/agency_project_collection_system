class TamuUser < ActiveRecord::Base
  def is_student?
    false
  end
  
  def is_professor?
    not is_student?
  end
  has_and_belongs_to_many :project
end
