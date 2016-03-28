# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
example_projects = [
  { name: "Test Project", description: "A completed test project", status: "completed"}
]

example_projects.each do |proj|
  Project.create!(proj)
end
