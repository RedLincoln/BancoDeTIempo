class Api::ServicesController < ApplicationController

  def index
    @services = !!params[:service_type] ?
                    Service.where(service_type: params[:service_type]) :
                    Service.all

    if logged_in?
      @services = @services.services_not_made_by(@user)
    end
  end

  def show
    @service = Service.find(params[:id])
  end

  def create
    login_guard
    service = @user.services.build(service_params)

    if service.save
      render json: { message: 'Servicio creado satisfactoriamente' }, status: :ok
    else
      render json: { message: 'Errores al crear servicio' }, status: :bad_request
    end
  end

  def update
    login_guard

    service = Service.find(params[:id])
    if service.update(service_params)
      render json: { message: 'Servicio actualizado' }, status: :ok
    else
      render json: { errors: service.errors }, status: :bad_request
    end

  end

  private

  def service_params
    params.permit(:name, :description, :category, :tags).merge(
        category: Category.find_by(name: params[:category]),
        tags: params[:tags].map { |name| Tag.build_or_get_tag_by_name(name)}
    )
  end
end
