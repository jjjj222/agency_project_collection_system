class Agency < ActiveRecord::Base
  has_many :projects
  
  #validates :name, presence: true
  #validates :email, email_format: { message: "doesn't look like an email address" }, presence: true
  #validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }
  def self.create_with_omniauth(auth)
    user = Agency.create!(:provider => auth["provider"], :uid => auth["uid"])
      #:name => auth["info"]["name"])
    user.save!
    user
  end

  #def self.from_omniauth(auth_hash)
  #  #byebug
  #  user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
  #  #user.email = auth_hash['info']['email']
  #  #user.name = auth_hash['info']['name']
  #  #user.location = auth_hash['info']['location']
  #  #user.image_url = auth_hash['info']['image']
  #  #user.url = auth_hash['info']['urls']['Google']
  #  user.save!
  #  user
  #end
end
