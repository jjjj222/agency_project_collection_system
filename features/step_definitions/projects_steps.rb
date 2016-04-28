Given /the following projects exist/ do |projects_table|
  uid = 0
  projects_table.hashes.each do |project|
    #byebug
    agency_name = project['agency']
    project.delete('agency')

    agency = Agency.find_by(name: agency_name)
    if (agency == nil)
      agency_hash = Hash.new
      agency_hash['provider'] = 'google_oauth2'
      agency_hash['uid'] = uid
      uid += 1
      agency_hash['email'] = 'agency@example.com'
      agency_hash['name'] = agency_name
      agency_hash['approved'] = true
      agency_hash['phone_number'] = "000-000-0000"
      agency = Agency.create(agency_hash)
    end

    project['tags'] = project['tags'].split(/[\s,]+/)

    agency.projects.create(project)
  end
end
