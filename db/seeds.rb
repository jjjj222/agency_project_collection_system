# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
example_projects = [
  { name: "Test Project", description: "A completed test project", status: "completed", approved: true},
  { name: "Test Project 2", description: "BCD", status: "completed", approved: true},
  { name: "Test Project 3", description: "BCD", status: "open", approved: false},
  { name: "Test Project 4", description: "BCD", status: "in progress", approved: false}
]

example_users = [
  { name: "John Tamu", email: "john@tamu.edu", role: "student", admin: false},
  { name: "Hank Tamu", email: "hank@tamu.edu", role: "professor", admin: false},
  { name: "Malini Malini", email: "malini@tamu.edu", role: "professor", admin: true}
  
]

example_agencies = [
  { name: "Some nonprofit", email: "noprofit@gmail.com", phone_number: "979-867-5309" },
  { name: "Another nonprofit", email: "noprofit2@gmail.com", phone_number: "979-555-5555" },
  { name: "Test agency", email: "test@test.com", phone_number: "979-555-5555" }

]


example_projects.each do |proj|
  Project.create!(proj)
end

example_users.each do |user|
  TamuUser.create!(user)
end

example_agencies.each do |agency|
  Agency.create!(agency)
end
