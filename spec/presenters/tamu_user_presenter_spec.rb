require 'spec_helper'

describe TamuUserPresenter do
  let(:tamu_user) { instance_double "TamuUser", role: @role, admin?: true, id: 1, name: "Test" }
  let(:presenter) { TamuUserPresenter.new tamu_user }

  describe "role" do
    it "should show student correctly" do
      @role = "student"
      expect(presenter.role).to eq("Student")
    end
    it "should show professor correctly" do
      @role = "professor"
      expect(presenter.role).to eq("Faculty")
    end
    it "should show unapproved professors correctly" do
      @role = "unapproved_professor"
      expect(presenter.role).to eq("Faculty (Unapproved)")
    end
  end

  describe "profile" do
    it "should generate a link to their page with their name" do
      link = presenter.profile
      expect(link).to include(presenter.name)
      expect(link).to include(presenter.tamu_user_path presenter.id)
    end
  end
end
