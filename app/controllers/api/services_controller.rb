class Api::ServicesController < ApplicationController

  def index
    @services = Service.find_by_category_name(params[:filter_category])
                    .find_by_category_supcategory(params[:filter_supcategory])

    if logged_in?
      @services = @services.services_not_made_by(@user)
    end
  end

  def show
    render json: { service: Service.find(params[:id])}
  end

  def create
    if !logged_in?
      render json: { message: 'Acceso denegado' }, status: :unprocessable_entity
    end

    tags = params[:tags].map { |name| Tag.build_or_get_tag_by_name(name)}
    category = Category.find_by(name: params[:category])

    service = @user.services.build(name: params[:name], description: params[:description], category: category)

    if service.save
      tags.each do |tag|
        service.tags << tag
      end
      render json: { message: 'Servicio creado satisfactoriamente' }
    else
      render json: { message: 'Errores al crear servicio' }, status: :bad_request
    end
  end
end
