module SessionHelpers
  def current_user
    @user ||= TamuUser.create! name: "Test Smith", email: "test@test.org", netid: "testNetid", role: "student", admin: false
  end
  def current_admin
    @admin ||= TamuUser.create! name: "Admin Doe", email: "admin@test.org", netid: "adminNetid", role: "professor", admin: true
  end
  def current_project
    @project ||= Project.create!(name: "Test Project", status: "open", description: "some desc", agency_id: current_agency.id, approved: true)
  end

  def unapproved_project
    @unapproved_project ||= Project.create!(name: "Test Project", status: "open", description: "some desc", agency_id: current_agency.id, approved: false)
  end

  def current_agency
    @agency ||= Agency.create!(name: "Test nonprofit", email: "test@testing.org", phone_number: "123-456-7890", approved: true)
  end

  def unapproved_agency
    @unapproved_agency ||= Agency.create!(name: "Test nonprofit", email: "test@testing.org", phone_number: "123-456-7890", approved: false)
  end
end
World(SessionHelpers)
