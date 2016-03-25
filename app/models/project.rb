class Project < ActiveRecord::Base

  def self.all_statuses
    ["completed","in progress","cancelled","open"]
  end

  belongs_to :agency
  has_and_belongs_to_many :project

  validates :status, :inclusion => { :in => Project.all_statuses }
  serialize :tags, Array
end
