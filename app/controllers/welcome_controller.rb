class WelcomeController < ApplicationController
  def index
    @projects = Project.where(status: "completed")
  end
end
