class WelcomeController < ApplicationController
  def index
    @projects = Project.where(status: "completed", approved: true)
  end
end
