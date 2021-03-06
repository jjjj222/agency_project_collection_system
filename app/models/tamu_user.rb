class TamuUser < ActiveRecord::Base
  
  def self.all_roles
    ["student","professor","unapproved_professor"]
  end
  
  def student?
    role == "student"
  end
  
  def professor?
    role == "professor"
  end

  def unapproved_professor?
    role == "unapproved_professor"
  end
  
  has_and_belongs_to_many :projects
  
  validates :name, presence: true
  validates :netid, presence: true
  validates :email, email_format: { message: "doesn't look like an email address" }, presence: true
  validates :role, :inclusion => { :in => TamuUser.all_roles }, presence: true
  validates :admin, :inclusion => {:in => [true, false]}
  validates :master_admin, inclusion: [true, false]
  validates :master_admin, exclusion: [true], if: 'not admin?'
end
