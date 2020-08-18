class ServicesController < ApplicationController
  before_action :authenticate_user!

  def new
    @service = Service.new
  end

  def create
    @workflow = CreateServices.new(name: params[:service][:name],
                                   description: params[:service][:description],
                                   user: current_user)
    @workflow.create
    redirect_to service_path(@workflow.service.id)
  end
end
