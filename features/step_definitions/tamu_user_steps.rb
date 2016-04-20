Given /the following TAMU Users exist/ do |tamu_users_table|
  tamu_users_table.hashes.each do |tamu_user|
    TamuUser.create tamu_user
  end
end
