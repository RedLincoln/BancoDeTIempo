class Api::ServicesController < ApplicationController

  def index
    service_type = !!params[:service_type] ? params[:service_type] : ''
    q = !!params[:q] ? params[:q] : ''
    category = !!params[:category] ? params[:category] : ''

    @services = Service.joins(:category).
        where('services.service_type LIKE ?', "%#{service_type}%").
        where('services.name ILIKE ?', "%#{q}%").
        where('categories.name ILIKE ?', "%#{category}%")


    @services = @services.services_not_made_by(@user) if logged_in?
    @total = @services.count

    @services = @services.
        limit(params[:limit]).
        offset(params[:offset])

    if params[:sort_order]
      case params[:sort_order]
      when 'category'
        @services = @services.sort { |a, b| a.category.name <=> b.category.name }
      when 'owner_name'
        @services = @services.sort { |a, b| a.user.name <=> b.user.name }
      else
        @services.order("updated_at")
      end
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
