# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
example_projects = [
  { name: "Test Project", description: "A completed test project", status: "completed", approved: true, agency_id: "1"},
  { name: "Test Project 2", description: "BCD", status: "completed", approved: true, agency_id: "2"},
  { name: "Test Project 3", description: "BCD", status: "open", approved: false, agency_id: "2"},
  { name: "Test Project 4", description: "BCD", status: "in progress", approved: false, agency_id: "3"}
]

example_users = [
  { name: "Admin", email: "admin@tamu.edu", netid: "jjjj222", role: "student", admin: true},
  { name: "John Tamu", email: "john@tamu.edu", netid: "johnsnetid", role: "student", admin: false},
  { name: "Hank Tamu", email: "hank@tamu.edu", netid: "hanksnetid", role: "professor", admin: false},
  { name: "Malini Malini", email: "malini@tamu.edu", netid: "malinisnetid", role: "professor", admin: true}
]

example_agencies = [
  { name: "Some nonprofit", email: "noprofit@gmail.com", phone_number: "979-867-5309", approved: true, provider: "fake", uid: "1" },
  { name: "Another nonprofit", email: "noprofit2@gmail.com", phone_number: "979-555-5555", approved: false, provider: "fake", uid: "2"},
  { name: "Test agency", email: "test@test.com", phone_number: "979-555-5555", provider: "test", uid: "3"}
]

# Fake admin. Netids must be 3-20 characters, so even if somehow added to production, should not be usable
fake_admin  = { name: "Admin", email: "admin@fake.org", netid: "ad", role: "professor", admin: true }


example_projects.each do |proj|
  Project.create!(proj)
end

example_users.each do |user|
  TamuUser.create!(user)
end

example_agencies.each do |agency|
  Agency.create!(agency)
end

case Rails.env
when "development"
  TamuUser.create!(fake_admin)
end
