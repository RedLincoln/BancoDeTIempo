class UserController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def services
    @services = current_user.services
  end
end
