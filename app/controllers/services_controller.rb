class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:update, :edit]

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to root_path }
      else
        format.js { render action: 'create' }
      end
    end
  end

  def create
    @workflow = CreateServices.new(service_params)
    @workflow.create
    if @workflow.valid?
      redirect_to root_path
    else
      @service = @workflow.service
      respond_to do |format|
        format.html { render new_service_path }
        format.js
      end
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description)
    {
        name: params[:service][:name],
        description: params[:service][:description],
        user: current_user
    }
  end

  def set_service
    @service = current_user.find_service(params[:id])
  end
end
