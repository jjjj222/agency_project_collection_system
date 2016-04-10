class Agency < ActiveRecord::Base
  has_many :projects

  validates :name, presence: true
  validates :email, email_format: { message: "doesn't look like an email address" }, presence: true
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }, :allow_blank => true
  validates :approved, :inclusion => {:in => [true, false]}

  def is_approved?
    approved == true
  end


  def self.create_with_omniauth(auth)
    parameters = {:provider => auth["provider"], :uid => auth["uid"]}
    #parameters[:approved] = false

    #byebug
    assign_if_not_nil(parameters, :email, auth['info']['email'])
    assign_if_not_nil(parameters, :name, auth['info']['name'])
    #assign_if_not_nil(parameters, :location, auth['info']['location'])
    #assign_if_not_nil(parameters, :image_url, auth['info']['image'])
    #assign_if_not_nil(parameters, :url, auth['info']['urls']['Google'])

    #user.email = auth_hash['info']['email']
    #user.name = auth_hash['info']['name']
    #user.location = auth_hash['info']['location']
    #user.image_url = auth_hash['info']['image']
    #user.url = auth_hash['info']['urls']['Google']

    user = Agency.create!(parameters)
    return user
  end

  private
  def self.assign_if_not_nil(hash, attribute, value)
    if value
        hash[attribute] = value
    end
  end
end
