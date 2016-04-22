Given /the following Agencies exist/ do |agencies_table|
  agencies_table.hashes.each do |agency|
    agency['provider'] = 'google_oauth2'
    Agency.create agency
  end
end
