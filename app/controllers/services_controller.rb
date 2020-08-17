class ServicesController < ApplicationController
  before_action :authenticate_user!

  def new

  end

  def create
    service = Service.new(
        name: params[:service][:name],
        description: params[:service][:name],
        user: current_user
    )
    if service.save
      puts service
      render json: service
    end

  end

  def edit

  end

end
