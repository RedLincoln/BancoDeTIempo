class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:update, :edit, :destroy]

  def index
    @services = Service.find_by_category_name(params[:filter_category]).services_not_made_by(current_user).pagination
  end

  def new
    @service = Service.new
  end

  def destroy
    @service.destroy
    respond_to do |format|
      format.js { flash.now[:notice] = 'Servicio eliminado' }
    end
  end


  def edit
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to root_path, notice: 'Servicio actualizado' }
      else
        flash.now[:alert] = 'Error al actualizar servicio'
        format.js { render action: 'create' }
      end
    end
  end

  def create
    @workflow = CreateServices.new(service_params)
    @workflow.create
    if @workflow.success?
      redirect_to root_path, notice: 'Servicio creado'
    else
      @service = @workflow.service
      respond_to do |format|
        format.html { render new_service_path }
        format.js { flash.now[:alert] = 'Error al crear servicio' }
      end
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :category)
    {
        name: params[:service][:name],
        description: params[:service][:description],
        category_id: params[:service][:category],
        user: current_user
    }
  end

  def set_service
    @service = current_user.find_service(params[:id])
  end
end
