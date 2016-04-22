class TamuUser < ActiveRecord::Base
  
  def self.all_roles
    ["student","professor"]
  end
  
  def is_student?
    role == "student"
  end
  
  def is_professor?
    role == "professor"
  end

  def self.create_with_cas(cas_hash)
    netid = cas_hash["user"]
    parameter = {:netid => netid}
    parameter[:uin] = cas_hash["extra_attributes"]["tamuEduPersonUIN"]

    parameter[:name] = netid
    parameter[:email] = "#{netid}@tamu.edu"
    parameter[:admin] = false
    parameter[:role] = 'student'


    user = TamuUser.create!(parameter)
    return user
  end
  
  has_and_belongs_to_many :projects
  
  validates :name, presence: true
  validates :email, email_format: { message: "doesn't look like an email address" }, presence: true
  validates :role, :inclusion => { :in => TamuUser.all_roles }, presence: true
  #validates :admin, :inclusion => {:in => [true, false]}, presence: true
  validates :admin, :inclusion => {:in => [true, false]}
end
