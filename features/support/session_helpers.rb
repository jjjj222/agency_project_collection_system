module SessionHelpers
  def current_user
    # TODO
    1
  end
  def current_project
    @project ||= Project.create!(name: "Test Project", status: "open", description: "some desc", agency_id: current_agency.id)
  end

  def current_agency
    @agency ||= Agency.create!(name: "Test nonprofit", email: "test@testing.org", phone_number: "123-456-7890")
  end
end
World(SessionHelpers)
