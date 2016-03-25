class Project < ActiveRecord::Base

  def self.all_statuses
    ["completed","in progress","cancelled","open"]
  end

  validates :status, :inclusion => { :in => Project.all_statuses }
  serialize :tags, Array
end
