class Project < ActiveRecord::Base
  serialize :tags, Array
end
