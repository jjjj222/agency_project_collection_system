class Project < ActiveRecord::Base

  def self.all_statuses
    ["completed","in progress","cancelled","open"]
  end
  
  def is_approved?
    approved == true
  end

  belongs_to :agency
  has_and_belongs_to_many :tamu_user

  validates :name, presence: true
  validates :status, :inclusion => { :in => Project.all_statuses }, presence: true
  validates :approved, :inclusion => {:in => [true, false]}
  serialize :tags, Array
end
