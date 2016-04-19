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
  if user_type.downcase == "agency"
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
  end
end

