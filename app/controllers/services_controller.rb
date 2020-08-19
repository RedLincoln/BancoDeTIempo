class ServicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def edit
    
  end

  def create
    @workflow = CreateServices.new(name: params[:service][:name],
                                   description: params[:service][:description],
                                   user: current_user)
    @workflow.create
    if @workflow.valid?
      redirect_to services_url
    else
      @service = @workflow.service
      respond_to do |format|
        format.html { render new_service_path }
        format.js
      end
    end
  end
end
