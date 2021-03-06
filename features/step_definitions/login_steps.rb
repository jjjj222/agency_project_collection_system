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
  user_login = ->(user) {
    visit root_path
    click_link "Login"
    click_link 'Sign in with CAS'
    fill_in 'username', with: user.netid
    fill_in 'password', with: "anything will do"
    click_button 'Login'
  }
  agency_login = ->(agency) {
    info_hash = Hash.new
    info_hash['name'] = 'Test User'
    info_hash['email'] = agency.email

    auth_hash = Hash.new
    auth_hash['info'] = info_hash
    auth_hash['provider'] = 'google_oauth2'
    auth_hash['uid'] = agency.uid

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)

    visit root_path
    click_link "Login"
    #click_link "Sign in with Google"
    click_link "google_login"
  }

  case underscore_words(user_type.downcase)

  when "admin"
    user_login.call(current_admin)
  when "master_admin"
    user_login.call(current_master_admin)
  when "tamu_user"
    user_login.call(current_user)
  when "agency"
    agency_login.call(current_agency)
  when "unapproved_agency"
    agency_login.call(unapproved_agency)
  end
end

