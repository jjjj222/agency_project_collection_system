class WelcomeController < ApplicationController
  
  skip_before_action :require_login
  
  def index
    @projects = Project.where(status: "completed", approved: true)
  end
end
