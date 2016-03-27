class Agency < ActiveRecord::Base
  has_many :projects
  
  validates :name, presence: true
  validates :email, email_format: { message: "doesn't look like an email address" }, presence: true
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }
end
