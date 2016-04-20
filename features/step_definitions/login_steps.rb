Given /the Google user exist/ do |user_table|
  info_hash = Hash.new
  user_table.hashes.each do |user|
    info_hash = user
  end

  auth_hash = Hash.new
  auth_hash['info'] = info_hash
  auth_hash['provider'] = 'google_oauth2'
  auth_hash['uid'] = info_hash['uid']

  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
end

Given /^I am logged in as (?:a|an) (.+)$/i do |user_type|
  user_type = user_type.downcase
  if user_type == "agency"
    info_hash = Hash.new
    info_hash['name'] = 'Test User'
    info_hash['email'] = 'test@gmail.com'

    auth_hash = Hash.new
    auth_hash['info'] = info_hash
    auth_hash['provider'] = 'google_oauth2'
    auth_hash['uid'] = '11111'

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)

    visit root_path
    click_link "Login"
    click_link "Sign in with Google"
  elsif user_type == "admin"
    hash = Hash.new
    hash['name'] = "Admin"
    hash['email'] = "admin@tamu.edu"
    hash['role'] = 'student'
    hash['admin'] = true
    TamuUser.create hash

    visit root_path
    click_link "Login"
    fill_in('Email', with: 'admin@tamu.edu')
    click_button('sign_in')
    #fill_in("session[email]", with: "user@tamu.edu")
  #| TAMU User Name | user@tamu.edu | student | true  |
    #click_link "Sign in with Google"
  #Given the following TAMU Users exist:
  #| name           | email         | role    | admin |
  #| TAMU User Name | user@tamu.edu | student | true  |

  #Given I am on the homepage
  #When  I follow "Login"
  #Then  I should be on login page
  #When  I fill in the "Email" field with "user@tamu.edu"
  #And   I press "sign_in"
  end
end

