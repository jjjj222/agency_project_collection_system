module SessionHelpers
  def current_user
    @user ||= TamuUser.create! name: "Test Smith", email: "test@test.org", netid: "testNetid", role: "student", admin: false
  end
  def current_admin
    @admin ||= TamuUser.create! name: "Admin Doe", email: "admin@test.org", netid: "adminNetid", role: "professor", admin: true
  end
  def current_project
    @project ||= Project.create!(name: "Test Project", status: "open", description: "some desc", agency: current_agency, approved: true)
  end

  def unapproved_project
    @unapproved_project ||= Project.create!(name: "Test Project", status: "open", description: "some desc", agency: current_agency, approved: false)
  end

  def current_agency
    @agency ||= Agency.create!(name: "Test nonprofit", email: "test@testing.org", phone_number: "123-456-7890", approved: true, uid: '11111', provider: 'google_oauth2' )
  end

  def unapproved_agency
    @unapproved_agency ||= Agency.create!(name: "Test nonprofit", email: "test@testing.org", phone_number: "123-456-7890", approved: false, uid: '12345', provider: 'google_oauth2')
  end
end
World(SessionHelpers)
