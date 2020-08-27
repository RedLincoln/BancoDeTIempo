class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    @transaction = Transaction.all
  end

  def services
    @services = current_user.services
  end
end
