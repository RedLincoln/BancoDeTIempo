class CategoryController < ApplicationController
  include AdminHelpers
  before_action :authenticate_admin, only: [:new, :create]

  def index
    @supcategories = Category.grouped_by_supcategory
    respond_to do |format|
      format.html
      format.json { render json: Category.search_by_name(params[:category_filter]).to_json }
    end
  end

  def new
    @category = Category.new
  end

  def create
    workflow = CreateCategories.new(category_params)
    workflow.create
    redirect_to root_path, notice: 'Categoria creada'
  end

  private
  def category_params
    params.require(:category).permit(:name, :supcategory)
    {
        name: params[:category][:name],
        supcategory: params[:category][:supcategory]
    }
  end

end
