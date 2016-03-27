class TamuUser < ActiveRecord::Base
  
  def is_student?
    false
  end
  
  def is_professor?
    not is_student?
  end
  
  has_and_belongs_to_many :projects
  
  validates :name, presence: true
  validates :email, email_format: { message: "doesn't look like an email address" }, presence: true
end
