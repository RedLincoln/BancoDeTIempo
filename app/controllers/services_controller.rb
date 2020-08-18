class ServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @workflow = CreateServices.new(name: params[:service][:name],
                                   description: params[:service][:description],
                                   user: current_user)
    @workflow.create
    redirect_to services_path
  end
end
